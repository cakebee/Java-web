package com.ResourceManage.controller;

import com.MessageManage.pojo.Message;
import com.MessageManage.service.MessageService;
import com.ResourceManage.pojo.Resource;
import com.ResourceManage.pojo.UserOwnedResources;
import com.ResourceManage.service.ResourceService;
import com.ResourceManage.service.UserOwnedResourcesService;
import com.UserManage.pojo.User;
import com.UserManage.service.UserService;
import com.Utils.Data.PathData;
import com.Utils.Pagination.PageBean;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ResourceController {

    @javax.annotation.Resource
    private ResourceService resourceService;

    @javax.annotation.Resource
    private UserOwnedResourcesService userOwnedResourcesService;

    @javax.annotation.Resource
    private PathData pathData;

    @javax.annotation.Resource
    private UserService userService;

    @javax.annotation.Resource
    private MessageService messageService;

    @RequestMapping("/test")
    public String test(){
        return "index";
    }

    /*浏览资源列表(同时也是根据关键词查找资源)*/
    @RequestMapping("/resourceList")
    public String resourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                               @RequestParam(value = "keyword",required = false)String keyword,
                               Model model,
                               HttpSession session){
        model.addAttribute("pagemsg",resourceService.selectByPage(currentPage,keyword,0));
        if (keyword!=null)
            model.addAttribute("keywords",keyword);
        return "resourceList";
    }

    /*浏览资源列表(同时也是根据关键词查找资源)*/
    @RequestMapping("/resourceList_Manage")
    public String resourceList_Manage(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                      @RequestParam(value = "keyword",required = false)String keyword,
                                      Model model){
        model.addAttribute("pagemsg",resourceService.selectByPage(currentPage,keyword,1));
        if (keyword!=null)
            model.addAttribute("keywords",keyword);
        return "resourceList_Manage";
    }

    /*浏览自己上传的资源列表*/
    @RequestMapping("/resourceUploaded")
    public String resourceList_Manage(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                      Model model,
                                      HttpSession session){
        String username = (String) session.getAttribute("username");
        model.addAttribute("pagemsg",resourceService.selectByPage(currentPage,username,2));
        return "resourceUploaded";
    }

    /*已经购买的资源*/
    @RequestMapping("/resourceOwn")
    public String OwnResource(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                              Model model,
                              HttpSession session){
        String username = (String) session.getAttribute("username");
        PageBean pageBean = userOwnedResourcesService.selectResourceByPage(currentPage,username);
        List<UserOwnedResources> ownedResourcesList = pageBean.getLists();
        List<Resource> resourceList = new ArrayList<Resource>();
        for(UserOwnedResources userOwnedResources:ownedResourcesList){
            resourceList.add(resourceService.selectResourceByID(userOwnedResources.getResourceid()));
        }
        pageBean.setLists(resourceList);
        model.addAttribute("pagemsg",pageBean);
        return "resourceOwn";
    }

    /*上传资源页面*/
    @RequestMapping("/resourceUpload")
    public ModelAndView uploadResource(){
        ModelAndView modelandview = new ModelAndView("resourceUpload");
        return modelandview;
    }

    /*上传资源*/
    @RequestMapping(value = "/resourceUploadResult",method = RequestMethod.POST)
    public ModelAndView uploadResourceResult(@RequestParam("name")String name,
                                             @RequestParam("description")String description,
                                             @RequestParam("price")String price,
                                             @RequestParam("file")MultipartFile file,
                                             Model model,
                                             HttpSession httpSession){
        String username = (String) httpSession.getAttribute("username");
        ModelAndView modelAndView = new ModelAndView("resourceUpload");
        int result = 0;
        //如果文件不为空,写入上传路径
        if (!file.isEmpty()){
            //上传文件路径
            String path = pathData.getResourcePath();
            //System.out.println(path);
            //上传文件名
            String filename = file.getOriginalFilename();
            File filepath = new File(path,filename);
            System.out.println(filepath.getPath());
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            //将上传文件保存到一个目标文件当中
            try {
                file.transferTo(new File(path + File.separator + filename));
            } catch (IOException e) {
                e.printStackTrace();
            }
            //创建resource对象
            Resource resource = new Resource();
            resource.setName(name);
            resource.setContent(description);
            resource.setPrice(Integer.valueOf(price));
            resource.setFilename(filename);
            resource.setUserid(username);
            resource.setFlag(1);
            resource.setTime(new Date());
            //插入到数据库
            result = resourceService.addResource(resource);
            System.out.println("result:"+result);
        }
        User user = userService.selectByUsername(username);
        if (result==1)
            model.addAttribute("resultOfUploadResource","上传成功，等待审核");
        else
            model.addAttribute("resultOfUploadResource","上传失败");
        model.addAttribute("userType",user.getType());
        return modelAndView;
    }

    /*下载资源*/
    @RequestMapping("/downloadResource")
    public ResponseEntity<byte[]> downloadResource(@RequestParam("fileName")String fileName,
                                                   @RequestParam("resourceID")int resourceID,
                                                   Model model,
                                                   HttpSession httpSession) throws Exception{
        String username = (String) httpSession.getAttribute("username");
        User user = userService.selectByUsername(username);
        //不是管理员、未购买资源、资源不是自己上传的
        if (!user.getType().equals("admin") && (userOwnedResourcesService.checkUserOwn(username,resourceID)==0) && !(resourceService.selectResourceByID(resourceID).getUserid().equals(username))){
            //下载次数+1
            Resource resource = resourceService.selectResourceByID(resourceID);
            int times = resource.getDownloadTimes();
            times=times+1;
            resource.setDownloadTimes(times);
            resourceService.updateResource(resource);
            //扣除下载者积分
            int totalscore = user.getCore();
            totalscore= totalscore-resource.getPrice();
            user.setCore(totalscore);
            userService.updateUser(user);
            //插入用户已经购买的资源表
            UserOwnedResources userOwnedResources = new UserOwnedResources();
            userOwnedResources.setUserid(username);
            userOwnedResources.setResourceid(resourceID);
            userOwnedResources.setScore(0);
            userOwnedResourcesService.addResource(userOwnedResources);
            //修改资源上传者的积分
            User user1 = userService.selectByUsername(resource.getUserid());
            totalscore = user1.getCore();
            totalscore=totalscore+resource.getPrice();
            user1.setCore(totalscore);
            userService.updateUser(user1);
        }
        //下载文件路径
        String path = pathData.getResourcePath();
        HttpHeaders httpHeaders = new HttpHeaders();
        //解决中文乱码问题
        String downloadFileName = new String(fileName.getBytes("iso-8859-1"),"UTF-8");
        File file = new File(path+File.separator+downloadFileName);
        //通知浏览器以attachment方式下载文件
        httpHeaders.setContentDispositionFormData("attachment",fileName);
        //application/octet-stream : 二进制流数据(最常见的文件下载)
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
                httpHeaders, HttpStatus.CREATED);
    }

    /*审核资源*/
    @RequestMapping("/checkResource")
    public String checkResource(@RequestParam("resourceID")int resourceID,Model model,@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage){
        Resource resource = resourceService.selectResourceByID(resourceID);
        resource.setFlag(0);
        resourceService.updateResource(resource);
        Message message = new Message();
        message.setReceid(resource.getUserid());
        message.setSendid("admin");
        message.setContent("resource:"+resource.getId()+"\n"+"name:"+resource.getName()+"\n"+"filename:"+resource.getFilename()+"\n"+"通过");
        message.setTitle("审核结果");
        message.setFlag((byte)0);//设置未读
        message.setSender((byte)0);//设置发送方发件箱中该消息未删除
        message.setReceiver((byte)0);//设置接收方收件箱中该消息未删除
        message.setSendtime(new Date());//设置消息发送时间
        messageService.send(message);
        model.addAttribute("pagemsg",resourceService.selectByPage(currentPage,null,1));
        return "resourceList_Manage";
    }

    /*删除资源*/
    @RequestMapping("/deleteResource")
    public String deleteResource(@RequestParam("deleteResourceID")int deleteResourceID,Model model,
                                 @RequestParam("deleteResourceName")String deleteResourceName,
                                 @RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage) throws UnsupportedEncodingException {
        Resource resource = resourceService.selectResourceByID(deleteResourceID);
        Message message = new Message();
        message.setReceid(resource.getUserid());
        message.setSendid("admin");
        message.setContent("resource:"+resource.getId()+"\n"+"name:"+resource.getName()+"\n"+"filename:"+resource.getFilename()+"\n"+"未通过");
        message.setTitle("审核结果");
        message.setFlag((byte)0);//设置未读
        message.setSender((byte)0);//设置发送方发件箱中该消息未删除
        message.setReceiver((byte)0);//设置接收方收件箱中该消息未删除
        message.setSendtime(new Date());//设置消息发送时间
        messageService.send(message);
        int result = resourceService.deleteResource(deleteResourceID);
        model.addAttribute("pagemsg",resourceService.selectByPage(currentPage,null,1));
        if(result==1){
            model.addAttribute("result","删除资源成功");
        }
        else {
            model.addAttribute("result","删除资源失败");
        }
        /*删除本地文件*/
        //文件路径
        String path = pathData.getResourcePath();
        HttpHeaders httpHeaders = new HttpHeaders();
        //解决中文乱码问题
        String downloadFileName = new String(deleteResourceName.getBytes("iso-8859-1"),"UTF-8");
        File file = new File(path+File.separator+downloadFileName);
        if (file.isFile() && file.exists())
            file.delete();
        return "resourceList_Manage";
    }

    /*显示资源的详细信息*/
    @RequestMapping("/showResource")
    public String showResource(@RequestParam("resourceID")int resourceID,
                               Model model,
                               HttpSession httpSession){
        String username = (String) httpSession.getAttribute("username");
        httpSession.setAttribute("resourceID",resourceID);
        User user = userService.selectByUsername(username);
        Resource resource = resourceService.selectResourceByID(resourceID);
        model.addAttribute("evalute",resource.getScore());
        //判断是否拥有资源
        int own = userOwnedResourcesService.checkUserOwn(username,resourceID);
        model.addAttribute("Own",own);
        //判断是否已经打过分
        int score = userOwnedResourcesService.selectScore(username,resourceID);
        model.addAttribute("score",score);
        model.addAttribute("resourceDetails",resource);
        model.addAttribute("userScore",user.getCore());
        return "resourceDetails";
    }

    //给资源打分
    @RequestMapping("/resourceEvaluate")
    public String resourceEvaluate(@RequestParam("resourceID")int resourceID,
                                   @RequestParam("score")int score,
                                   @RequestParam("username")String username,
                                   Model model){
        System.out.println("resourceID");
        //插入单次评分
        UserOwnedResources userOwnedResources = userOwnedResourcesService.selectByID(resourceID,username);
        userOwnedResources.setScore(score);
        model.addAttribute("score",score);
        userOwnedResourcesService.updateByPrimaryKey(userOwnedResources);
        //更新资源评分
        Resource resource = resourceService.selectResourceByID(resourceID);
        int totalScore = userOwnedResourcesService.countScore(resourceID);
        System.out.println("total:"+totalScore);
        int times = userOwnedResourcesService.countTimes(resourceID);
        System.out.println("times:"+times);
        DecimalFormat avaragescore = new DecimalFormat("0.0");
        String total = null;
        Double Avarage = 0.0;
        if (times!=0)
            total = avaragescore.format((float)totalScore/times);
        if (total!=null)
            Avarage = Double.valueOf(total);
        resource.setScore(Avarage);
        System.out.println("avarage:"+Avarage);
        resourceService.updateResource(resource);
        return "redirect:/showResource?resourceID="+resourceID;
    }
}
