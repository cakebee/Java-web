package com.CourseManage.controller;

import com.CourseManage.pojo.*;
import com.CourseManage.service.CourseImageService;
import com.CourseManage.service.CourseIndexService;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.UserManage.service.UserService;
import com.Utils.Data.PathData;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CousreManageController {

    @Resource
    private CourseManageService courseManageService;
    @Resource
    private CourseImageService courseImageService;
    @Resource
    private PathData pathData;
    @Resource
    private UserService userService;
    @Resource
    private CourseIndexService courseIndexService;
    @Resource
    private CourseNoticeService courseNoticeService;

    /*
        发布课程页面
     */
    @RequestMapping("/releaseCourse")
    public ModelAndView releaseCourse(ModelMap model){
        ModelAndView modelandview = new ModelAndView("releaseCourse", "command", new Course());
        model.addAttribute("tags",userService.getTags());
        return modelandview;
    }

    /*
        处理课程发布结果
     */
    @RequestMapping("/releaseResult")
    public ModelAndView releaseResult(HttpSession session,
                                      @RequestParam("coursename") String coursename,
                                      @RequestParam("coursetype") String coursetype,
                                      @RequestParam("intro") String intro,
                                      @RequestParam("price") int price,
                                      @RequestParam("Image") MultipartFile image,
                                      Model model) throws IOException {
        Course course = new Course();
        course.setTeacher((String)session.getAttribute("username"));
        course.setCoursename(coursename);
        course.setCoursetype(coursetype);
        course.setIntro(intro);
        course.setPrice(price);

        byte[] b1 = image.getBytes();
        int result = courseManageService.releaseCourse(course);
        int result1 = courseImageService.insert(b1,result);

        model.addAttribute("tags",userService.getTags());

        ModelAndView modelandview = new ModelAndView("releaseCourse", "command", course);

        if(result==1){
            model.addAttribute("result","申请成功，请等待审核");
        }else{
            model.addAttribute("result","发布失败");
        }
        if(result1==1){
            model.addAttribute("result","图片上传成功");
        }else{
            model.addAttribute("result","发图片上传失败");
        }

        return modelandview;

    }
    /*
        显示课程图片
     */
    @RequestMapping("/showcourseimage")
    public @ResponseBody
    void showCourseimage(@RequestParam("courseid")int courseid, HttpServletResponse response)throws IOException {
        CourseImage courseImage = courseImageService.select(courseid);
        byte[] image = courseImage.getCourseImage();
        ServletOutputStream out = response.getOutputStream();
        out.write(image, 0, image.length);
        out.flush();
        out.close();
    }


    /*
        展示我的课程列表
     */
    @RequestMapping("/showMyCourseList")
    public String showMyCourseList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                    HttpSession session,
                                    Model model){

        model.addAttribute("pagemsg",courseManageService.showMyCourseListByPage(currentPage,(String)session.getAttribute("username")));
        return "coursePage/showMyCourseList";
    }

    /*
        编辑课程页面
     */
    @RequestMapping("/editCourse")
    public String editCourse(@RequestParam("courseID")int courseID,
                              ModelMap model){

        Course course = courseManageService.showCourse(courseID);

        CourseandImaga courseandImaga = new CourseandImaga();

        courseandImaga.setId(course.getId());
        courseandImaga.setCoursename(course.getCoursename());
        courseandImaga.setCoursetype(course.getCoursetype());
        courseandImaga.setFlag(course.getFlag());
        courseandImaga.setIntro(course.getIntro());
        courseandImaga.setTeacher(course.getTeacher());
        courseandImaga.setPrice(course.getPrice());

        model.addAttribute("returnCourse",courseandImaga);
        model.addAttribute("editedCoursename",course.getCoursename());
        model.addAttribute("tags",userService.getTags());

        return "editCourse";
    }

    /*
        编辑课程图片页面
    */
    @RequestMapping("/editCourseImage")
    public String editCourseImage(@RequestParam("courseID") int courseid,Model model,
                                  @RequestParam("Image") MultipartFile image) throws IOException{

        int result = courseImageService.updateByCourseid(image.getBytes(),courseid);
        Course course = courseManageService.showCourse(courseid);

        model.addAttribute("returnCourse",course);
        model.addAttribute("editedCoursename",course.getCoursename());
        model.addAttribute("tags",userService.getTags());


        return "editCourse";
    }

    /*
        提交编辑结果
     */
    @RequestMapping("/updateCourse")
    public String updateCourse(@RequestParam("courseID")int courseID,CourseandImaga courseandImaga,ModelMap model)throws IOException{

        Course course = new Course();
        course.setId(courseID);
        courseandImaga.setId(courseID);
        model.addAttribute("tags",userService.getTags());

        course.setCoursename(courseandImaga.getCoursename());
        course.setCoursetype(courseandImaga.getCoursetype());
        course.setFlag(courseandImaga.getFlag());
        course.setIntro(courseandImaga.getIntro());
        course.setTeacher(courseandImaga.getTeacher());
        course.setPrice(courseandImaga.getPrice());

        int result = courseManageService.editCourse(course);

        if(courseandImaga.getImage().isEmpty()){
            if(result == 1){
                model.addAttribute("result","编辑成功！");
            }else{
                model.addAttribute("result","您没有更新任何信息！");
            }
        }else{
            int result_image = courseImageService.updateByCourseid(courseandImaga.getImage().getBytes(),courseID);
            if(result_image == 1){
                model.addAttribute("result","编辑成功！");
            }else{
                model.addAttribute("result","编辑失败！");
            }
        }

        model.addAttribute("returnCourse",courseandImaga);
        model.addAttribute("editedCoursename",course.getCoursename());

        return "editCourse";
    }

    /*
        删除课程
     */
    @RequestMapping("/deleteCourse")
    public String  deleteCourse(@RequestParam("courseID")int courseID,
                                HttpSession session,ModelMap model)throws Exception{

        int result = courseManageService.deleteCourse(courseID);

        if(result == 1){
            model.addAttribute("result","删除成功！");

        }else{
            model.addAttribute("result","删除失败！");
        }

        model.addAttribute("pagemsg",courseManageService.showMyCourseListByPage(1,(String)session.getAttribute("username")));
        return "coursePage/showMyCourseList";
    }

    /*
        已审核通过课程资源列表
     */
    @RequestMapping("/showPassCourseResourceList")
    public String showPassCourseResourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                             @RequestParam("courseID")int courseID,
                                             Model model){
        List<CourseIndex> courseIndexList = courseIndexService.getCourseIndexList(courseID);
        List<CourseResources> courseResources = courseManageService.showPassCourseResourceList(courseID);
        List<Integer> isIn = new ArrayList<Integer>();
        CourseIndex courseIndex;

        for(int i=0; i<courseResources.size(); i++){
            isIn.add(courseResources.get(i).getId());
            System.out.println(isIn.get(i));
        }
        for(int i=courseIndexList.size()-1; i>=0; i--){
            courseIndex = courseIndexList.get(i);
            if(!isIn.contains(courseIndex.getVideo())){
                courseIndex.setVideo(-1);
            }
            if(!isIn.contains(courseIndex.getWord())){
                courseIndex.setWord(-1);
            }
            if(!isIn.contains(courseIndex.getPdf())){
                courseIndex.setPdf(-1);
            }
            if((courseIndex.getVideo()==-1) && (courseIndex.getPdf()==-1) && (courseIndex.getWord()==-1)){
                System.out.println("删除对象" + i);
                courseIndexList.remove(i);
                System.out.println("大小：" + courseIndexList.size());
            }else {
                courseIndexList.set(i, courseIndex);
            }
        }

        model.addAttribute("courseIndexList",courseIndexList);
        model.addAttribute("coursename",courseManageService.showCourse(courseID).getCoursename());
        model.addAttribute("courseID",courseID);
        model.addAttribute("pagemsg",courseManageService.showPassCourseResourceListByPage(currentPage,courseID));

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        return "showPassCourseResource";
    }

    /*
        我的课程资源列表
     */
    @RequestMapping("/showCourseResourceList")
    public String showCourseResourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                         @RequestParam("courseID")int courseID,
                                         Model model){
        model.addAttribute("coursename",courseManageService.showCourse(courseID).getCoursename());
        model.addAttribute("pagemsg",courseManageService.showCourseResourceListByPage(currentPage,courseID));

        return "MyCourseResource";
    }

    /*
        上传课程资源
     */
    @RequestMapping("/uploadCourseResource")
    public String uploadCourseResource(@RequestParam("courseID")int courseID,ModelMap model){

        model.addAttribute("coursename",courseManageService.showCourse(courseID).getCoursename());
        model.addAttribute("courseID",courseID);

        return "uploadCourseResource";
    }

    /*
        处理上传结果
     */
    @RequestMapping("/uploadResult")
    public String uploadResult(@RequestParam("courseID")int courseID,
                               @RequestParam("type")String type ,
                               @RequestParam("name")String name ,
                               @RequestParam("file") MultipartFile file,
                               @RequestParam("chapter")int chapter,
                               @RequestParam("chapterTitle")String chapterTitle,
                               @RequestParam("part")int part,
                               @RequestParam("partTitle")String partTitle,ModelMap model) throws Exception {

        CourseIndex courseIndex = new CourseIndex();
        String filename = file.getOriginalFilename();
        System.out.println(filename);

        model.addAttribute("coursename",courseManageService.showCourse(courseID).getCoursename());
        int id = courseManageService.uploadCourseFileResource(courseID,type,name,file);
        System.out.println(id);

        if(id > 0){//不知道怎么改
            model.addAttribute("result","上传成功！");
            courseIndex.setCourseid(courseID);
            courseIndex.setChapter(chapter);
            courseIndex.setChaprtTitle(chapterTitle);
            courseIndex.setPart(part);
            courseIndex.setPartTitle(partTitle);
            courseIndex.setPdf(-1);
            courseIndex.setWord(-1);
            courseIndex.setVideo(-1);
            if(type.equals("Video")){
                courseIndex.setVideo(id);
            }else if(type.equals("Pdf")){
                courseIndex.setPdf(id);
            }else if(type.equals("Word")){
                courseIndex.setWord(id);
            }
            if(courseIndexService.isExist(courseIndex)){
                int courseIndexID = courseIndexService.getCouseIndexID(courseIndex);
                courseIndexService.updateCourseResource(courseIndexID, type, id);
            }else {
                courseIndexService.addCourseIndex(courseIndex);
            }
        }else{
            model.addAttribute("result","上传失败！");
        }
        return "uploadCourseResource";
    }

    /*
        下载课程资源
        crID:课程资源ID
        courseID：课程ID
     */
    @RequestMapping("/downloadCourseResource")
    public ResponseEntity<byte[]> downloadCourseResource(@RequestParam("crID")int crID,
                                                         @RequestParam("courseID")int courseID ) throws IOException {

        String path = pathData.getCoursePath()+File.separator+courseManageService.showCourse(courseID).getTeacher()+
                courseManageService.showCourse(courseID).getCoursename()+File.separator+courseManageService.getCourseResource(crID).getFilename();

        String filename = new String(courseManageService.getCourseResource(crID).getFilename().getBytes("gb2312"),
                "iso8859-1");

        File file = new File(path);

        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", filename);

        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);

    }

    /*
        删除课程资源
     */
    @RequestMapping("/deleteCourseResource")
    public String deleteCourseResourece(@RequestParam("crID")int crID,
                                        @RequestParam("courseID")int courseID, ModelMap model){

        courseManageService.deleteCourseResource(crID);

        model.addAttribute("coursename",courseManageService.showCourse(courseID).getCoursename());
        model.addAttribute("pagemsg",courseManageService.showCourseResourceListByPage(1,courseID));

        return "MyCourseResource";

    }



    /*
        在线播放跳转页面
     */
    @RequestMapping("/playVideo")
    public String playVideo(@RequestParam("crID")int crID,
                            @RequestParam("courseID")int courseID,ModelMap model){

        model.addAttribute("crID",crID);
        model.addAttribute("courseID",courseID);
        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        model.addAttribute("courseIndex", courseIndexService.getCourseIndex(crID));
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        model.addAttribute("resourceName",courseManageService.getCourseResource(crID).getName());

        return "videoPage/videoPlay";
    }

    /*
        获取视频流
     */
    @RequestMapping("/video")
    public @ResponseBody
    void video(@RequestParam("crID")int crID,
               @RequestParam("courseID")int courseID, HttpServletResponse response)throws Exception{

        String path = pathData.getCoursePath()+File.separator+courseManageService.showCourse(courseID).getTeacher()+
                courseManageService.showCourse(courseID).getCoursename()+File.separator+courseManageService.getCourseResource(crID).getFilename();

        File file = new File(path);
        FileInputStream in = new FileInputStream(file);
        ServletOutputStream out = response.getOutputStream();
        byte[] b = null;
        while(in.available() >0) {
            if(in.available()>10240) {
                b = new byte[10240];
            }else {
                b = new byte[in.available()];
            }
            in.read(b, 0, b.length);
            out.write(b, 0, b.length);
        }
        in.close();
        out.flush();
        out.close();
    }



    /*
        某课程首页
     */
    @RequestMapping("/courseIndex")
    public String gotoCourse(@RequestParam("courseID")int courseID,
                             HttpSession session,ModelMap model){

        model.addAttribute("courseID", courseID);
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        if(courseManageService.checkMyParticipate(courseID,(String)session.getAttribute("username"))){
            model.addAttribute("state","in");
        }else{
            model.addAttribute("state","out");
        }

        return "courseIndex";
    }

    /*
        参与学习
     */
    @RequestMapping("/participateLearning")
    public String participateLearning(@RequestParam("courseID")int courseID,
                                      @RequestParam("username")String username,
                                      HttpSession session,ModelMap model){

        courseManageService.participateLearning(courseID,username);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        if(courseManageService.checkMyParticipate(courseID,(String)session.getAttribute("username"))){
            model.addAttribute("state","in");
        }else{
            model.addAttribute("state","out");
        }



        return "courseIndex";
    }

    /*
        查看我参与学习的课程
     */
    @RequestMapping("/showMyParticipateCourse")
    public String showMyParticipateCourse(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                          HttpSession session,Model model){

        model.addAttribute("pagemsg",courseManageService.showMyParticipateCourse(currentPage,
                (String)session.getAttribute("username")));

        return "myParticipateCourse";
    }

    /*
        退出学习
     */
    @RequestMapping("/abortMyCourse")
    public String abortMyCourse(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                @RequestParam("courseID")int courseid,
                                HttpSession session,Model model){

        int result = courseManageService.abortMyCourse((String)session.getAttribute("username"),courseid);

        model.addAttribute("pagemsg",courseManageService.showMyParticipateCourse(currentPage,
                (String)session.getAttribute("username")));

        if(result == 1){
            model.addAttribute("result","退出成功！");

        }else{
            model.addAttribute("result","退出失败！");
        }

        return "myParticipateCourse";
    }


    /*
        全部课程页面
        展示所有已通过审核的课程
        type = 4
     */
    @RequestMapping("/course")
    public String courseIndex(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                              ModelMap model){


        model.addAttribute("pagemsg",courseManageService.showKeyCourseListsByPage(currentPage,4,""));
        model.addAttribute("coursetypes",userService.getTags());

        model.addAttribute("searchType",4);
        model.addAttribute("keywords","null");

        return "course";

    }

    /*
        根据用户的兴趣，展示推荐的课程
        type = 5
     */
    @RequestMapping("/myInterestCourse")
    public String myInterestCourse(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                   @RequestParam("searchType")int searchType,
                                   HttpSession session,ModelMap model){

        model.addAttribute("pagemsg",courseManageService.showMyInterestCourseListByPage(currentPage,
                (String)session.getAttribute("username")));

        model.addAttribute("coursetypes",userService.getTags());

        model.addAttribute("searchType",searchType);

        model.addAttribute("keywords","null");

        return "course";
    }

    /*
        分页展示热门课程
     */
    @RequestMapping("/hotCourse")
    public String showHotCourse(ModelMap model){

        model.addAttribute("pagemsg",courseManageService.showHotCourse());
        model.addAttribute("coursetypes",userService.getTags());

        model.addAttribute("keywords","null");

        return "course";
    }

    /*
        搜索课程:
        根据关键字搜索课程
        根据教师关键字搜索教师课程
     */
    @RequestMapping("/searchCourse")
    public String searchCourse(@RequestParam("keywords")String keywords,
                               @RequestParam("searchType")int searchType,
                               @RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                               ModelMap model
                               ){

        model.addAttribute("pagemsg",courseManageService.showKeyCourseListsByPage(currentPage,searchType,keywords));
        model.addAttribute("coursetypes",userService.getTags());

        model.addAttribute("keywords",keywords);
        model.addAttribute("searchType",searchType);

        return "course";

    }

    /*
        展示该课程学生成绩排名
     */
    @RequestMapping("/showStuScoreRank")
    public String showStuScoreRank(@RequestParam("courseID")int courseID,
                                   @RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,ModelMap model){

        model.addAttribute("pagemsg",courseManageService.showStuScoreRank(currentPage,courseID));

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        model.addAttribute("courseID",courseID);

        return "stuScoreRank";
    }

    /*
        查看我的所有课程成绩
     */
    @RequestMapping("/showMyAllCourseScore")
    public String showMyAllCourseScore(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                                       HttpSession session,ModelMap model){

        model.addAttribute("pagemsg",courseManageService.showMyAllCourseScore((String)session.getAttribute("username"),currentPage));

        return "showMyAllCourseScore";
    }

}
