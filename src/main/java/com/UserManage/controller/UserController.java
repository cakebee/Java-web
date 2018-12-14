package com.UserManage.controller;

import com.UserManage.pojo.User;
import com.UserManage.pojo.UserAndImage;
import com.UserManage.pojo.UserImage;
import com.UserManage.service.UserService;
import com.UserManage.service.UserimageService;
import com.Utils.CalculatorUtil;
import com.Utils.Data.translation;
import com.Utils.SendmailUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;
import java.util.Random;

@Controller
public class UserController {
    @Resource
    private UserService service;
    @Resource
    private UserimageService userimageService;
    // @Resource
    // private HttpServletRequest request;
    @Resource
    private translation trans;
    private String editname;
    private String username;
    private String editedname;
    /*
        登录页面
     */
    @RequestMapping(value = "/login")
    public ModelAndView login() {
        ModelAndView modelandview = new ModelAndView("login", "command", new User());
        return modelandview;
    }

    /*
        处理登录结果
     */

    @RequestMapping(value ="/loginResult")
    public ModelAndView loginResult(@ModelAttribute User user, ModelMap model,HttpSession session,HttpServletRequest request,HttpServletResponse response){
        ModelAndView modelandview;
        String code = (String) request.getSession().getAttribute("code");
        String checkCode = request.getParameter("checkCode").toUpperCase();
        response.setCharacterEncoding("utf-8");
        //调用UserService的login方法，进行登录处理
        String result = service.login(user);
        if("error".equals(result)){
            modelandview = new ModelAndView("login", "command", user);
            model.addAttribute("result","登录失败");
        }
        else if(code.equals(checkCode)==false){
            modelandview = new ModelAndView("login", "command", user);
            model.addAttribute("result","登录失败,验证码错误");
        }
        else{
            if("admin".equals(result)){
                modelandview = new ModelAndView("adminIndex");
                session.setAttribute("username",user.getUsername());//set the login username
                session.setAttribute("type",service.getUserType(user.getUsername()));//set the login type
                model.addAttribute("result","登录成功");

            }else{
                modelandview = new ModelAndView("PersonalCenter" );
                session.setAttribute("username",user.getUsername());//set the login username
                session.setAttribute("type",service.getUserType(user.getUsername()));//set the login type
                model.addAttribute("result","登录成功");
            }

        }
        return modelandview;
    }
    /*
        退出登录
     */
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request,HttpSession session){
        session.invalidate();
        request.setAttribute("result","您已退出会话！");
        return new ModelAndView("login","command",new User());
    }

    /*
        注册页面
     */
    @RequestMapping(value = "/register")
    public ModelAndView register() {
        ModelAndView modelandview = new ModelAndView("register", "command", new User());
        return modelandview;
    }
    @RequestMapping(value = "VerificationCode/generate.action", method = {RequestMethod.POST, RequestMethod.GET})
    public void VerificationCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        int width = 90;// 定义图片的width
        int height = 20;// 定义图片的height
        int codeCount = 4;// 定义图片上显示验证码的个数
        int xx = 15;
        int fontHeight = 18;
        int codeY = 16;
        char[] codeSequence = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

        // 定义图像buffer
        BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics gd = buffImg.getGraphics();
        // 创建一个随机数生成器类
        Random random = new Random();
        // 将图像填充为白色
        gd.setColor(Color.WHITE);
        gd.fillRect(0, 0, width, height);
        // 创建字体，字体的大小应该根据图片的高度来定。
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
        // 设置字体。
        gd.setFont(font);
        // 画边框。
        gd.setColor(Color.BLACK);
        gd.drawRect(0, 0, width - 1, height - 1);
        // 随机产生40条干扰线，使图象中的认证码不易被其它程序探测到。
        gd.setColor(Color.BLACK);
        for (int i = 0; i < 40; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            gd.drawLine(x, y, x + xl, y + yl);
        }
        // randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
        StringBuffer randomCode = new StringBuffer();
        int red = 0, green = 0, blue = 0;
        // 随机产生codeCount数字的验证码。
        for (int i = 0; i < codeCount; i++) {
            // 得到随机产生的验证码数字。
            String code = String.valueOf(codeSequence[random.nextInt(codeSequence.length-1)]);
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。
            red = random.nextInt(255);
            green = random.nextInt(255);
            blue = random.nextInt(255);
            // 用随机产生的颜色将验证码绘制到图像中。
            gd.setColor(new Color(red, green, blue));
            gd.drawString(code, (i + 1) * xx, codeY);
            // 将产生的四个随机数组合在一起。
            randomCode.append(code);
        }
        // 将四位数字的验证码保存到Session中。
        HttpSession session = req.getSession();
        System.out.print(randomCode);
        session.setAttribute("code", randomCode.toString());
        // 禁止图像缓存。
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        resp.setContentType("image/jpeg");
        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos = resp.getOutputStream();
        ImageIO.write(buffImg, "jpeg", sos);
        sos.close();
    }
    /*
        处理注册结果
     */
    @RequestMapping(value ="/registerResult", method = RequestMethod.POST)
    public ModelAndView registerResult(@ModelAttribute("SpringWeb")User user,ModelMap model,HttpServletRequest request,HttpServletResponse response) throws IOException {
        ModelAndView modelandview = null;
        String code = (String) request.getSession().getAttribute("idcode");
        String checkCode = request.getParameter("idcode").toUpperCase();
        response.setCharacterEncoding("utf-8");
        if(code.equals(checkCode)==true){
            int result = service.addUser(user);
            if(result==1){
                modelandview = new ModelAndView("login", "command", user);
                model.addAttribute("result", "注册成功");
                //TODO:3s后跳转到登录界面
                //model.addAttribute("url", "login");
                return modelandview;
            }
            else{
                modelandview = new ModelAndView("register", "command", user);
                model.addAttribute("result", "注册失败");
                //TODO:3s后跳转到注册界面
                // model.addAttribute("url", "register");
                return modelandview;
            }
        }
        modelandview = new ModelAndView("register", "command", user);
        model.addAttribute("result", "注册失败,验证码错误");
        //TODO:3s后跳转到注册界面
        // model.addAttribute("url", "register");
        return modelandview;
    }

    /*
        显示用户列表
    */
    @RequestMapping("/showUserList")
    public String showUserList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                               Model model){

        model.addAttribute("pagemsg", service.showUserListByPage(currentPage));//回显分页数据

        //model.addAttribute("username",username);//回显用户名
        //System.out.println("正访问管理员用户信息页用户："+username);
        return "showUserList";
    }
       /*
        显示上传用户图片
    */

    @RequestMapping("/showimage")
    public @ResponseBody
    void  showimage(@RequestParam("userid")String userid, HttpServletResponse response) throws IOException {
        UserImage userImage = userimageService.selectByUserid(userid);
        byte[] image = userImage.getUserimage();
        ServletOutputStream out = response.getOutputStream();
        out.write(image, 0, image.length);
        out.flush();
        out.close();
    }
    /*
       编辑用户图片
    */
    @RequestMapping("/editUserImage")
    public ModelAndView editUserImage(@RequestParam("editUsername") String editUsername,
                                      @RequestParam("Image") MultipartFile image,
                                      @RequestParam("editedUsername") String editedUsername,
                                      Model model) throws IOException {
        int result = userimageService.updateByUserid(image.getBytes(),editUsername);

        ModelAndView modelandview = new ModelAndView("showUser", "returnUser", new User());

        //System.out.println(user.getUsername());
        //System.out.println(user.getSign());

        model.addAttribute("editedUsername",editUsername);
        model.addAttribute("type",service.getUserType(editedUsername));
        model.addAttribute("editUsername",editUsername);//返回编辑者用户名
        if(result==1){
            model.addAttribute("result1","头像更新成功");
        }else{
            model.addAttribute("result1","头像更新失败");
        }

        return modelandview;
    }

    /*
        显示用户详细信息
        username:编辑用户
        editedUsername：被编辑的用户
     */
    @RequestMapping("/showUser")
    public String showUser(@RequestParam("username") String username,
                           @RequestParam("editedUsername") String editedUsername,Model model){

        User user =service.selectByUsername(editedUsername);

        UserAndImage userAndImage = new UserAndImage();

        userAndImage.setId(user.getId());
        userAndImage.setUsername(user.getUsername());
        userAndImage.setAddress(user.getAddress());
        userAndImage.setEmail(user.getEmail());
        userAndImage.setPassword(user.getPassword());
        userAndImage.setCore(user.getCore());
        userAndImage.setSign(user.getSign());


        model.addAttribute("returnUser", userAndImage);

        model.addAttribute("editedUsername",editedUsername);
        model.addAttribute("editUsername",username);

        return "showUser";
    }


    /*
        编辑用户
        editUsername:编辑者用户
        editedUsername：被编辑的用户
     */
    @RequestMapping("/editUser")
    public ModelAndView editUser(@RequestParam("editUsername") String editUsername,
                                 @RequestParam("editedUsername") String editedUsername,
                                 UserAndImage userAndImage, ModelMap model)throws IOException{

        //编辑后停留展示用户详细页面，显示编辑结果
        User user = new User();
        user.setUsername(editedUsername);
        user.setAddress(userAndImage.getAddress());
        user.setEmail(userAndImage.getEmail());
        user.setPassword(userAndImage.getPassword());
        user.setSign(userAndImage.getSign());

        ModelAndView modelandview = new ModelAndView("showUser", "returnUser", userAndImage);

        model.addAttribute("editedUsername",editedUsername);
        model.addAttribute("type",service.getUserType(editUsername));
        model.addAttribute("editUsername",editUsername);//返回编辑者用户名

        int result = service.updateByUsername(user,editUsername,editedUsername);

        if(userAndImage.getImage().isEmpty()){

            if(result==1){
                model.addAttribute("result","编辑成功");
            }else{
                model.addAttribute("result","编辑失败");
            }
        }else{
            int result_image = userimageService.updateByUserid(userAndImage.getImage().getBytes(),editedUsername);
            if(result==1||result_image==1){
                model.addAttribute("result","编辑成功");
            }else{
                model.addAttribute("result","编辑失败");
            }
        }



        return modelandview;
    }

    /*
        删除用户
        deletedUsername:被删除的用户
     */
    @RequestMapping("/deleteUser")
    public String deleteUser(@RequestParam("deletedUsername") String deletedUsername,ModelMap model){

        int result = service.deleteByUsername(deletedUsername);
        model.addAttribute("pagemsg", service.showUserListByPage(1));//回显分页数据
        if(result == 1){
            model.addAttribute("result","删除成功");
        }else{
            model.addAttribute("result","删除失败");
        }
        return "showUserList";
    }
    /*
        查看用户积分
     */
    @RequestMapping("/myIntegral")
    public String myIntegral(HttpSession session,ModelMap model){
        String username = (String)session.getAttribute("username");
        model.addAttribute("score",service.checkIntegral(username).get("integral"));
        model.addAttribute("rank",service.checkIntegral(username).get("level"));
        return "myIntegral";
    }

    /*
        修改密码
     */
    @RequestMapping("/chpassword")
    public ModelAndView chpassword(){

        ModelAndView modelandview = new ModelAndView("chpassword", "command", new User());
        return modelandview;

    }

    /*
        修改密码结果
     */
    @RequestMapping("/chPassResult")
    public ModelAndView chPassResult(@ModelAttribute(value = "command") User user,HttpSession session,ModelMap model){
        ModelAndView modelandview = new ModelAndView("chpassword", "command", new User());
        //获取用户名
        String username = (String)session.getAttribute("username");
        int result = service.updatePassByUsername(username,user);

        if(result==1){
            model.addAttribute("result","修改密码成功！");
        }else if(result==2){
            model.addAttribute("result","原密码输入错误！");
        }else{
            model.addAttribute("result","修改失败！");
        }
        return modelandview;
    }

    /*
        找回密码
     */
    @RequestMapping("/findPass")
    public ModelAndView findPass(){

        ModelAndView modelandview = new ModelAndView("findPassword", "command", new User());
        return modelandview;

    }

    /*
        找回结果
     */
    @RequestMapping("/findPassResult")
    public ModelAndView findPassResult(@ModelAttribute(value = "command") User user,ModelMap model){
        ModelAndView modelandview = new ModelAndView("findPassword", "command", new User());
        System.out.println(user.getUsername());
        Map map = service.findPass(user);
        model.addAttribute("result",map.get("result"));
        model.addAttribute("password",map.get("password"));

        return modelandview;
    }

    /*
        我的兴趣列表
     */
    @RequestMapping("/myInterest")
    public String showMyInterest(HttpSession session,ModelMap model){

        model.addAttribute("tags",service.getTags());
        model.addAttribute("mytags",service.showMyTags((String)session.getAttribute("username")));

        return "myInterestTags";
    }

    /*
        提交我的兴趣
     */
    @RequestMapping("/addMyInterest")
    public String addMyInterest(@RequestParam("username")String username,
                                @RequestParam("tags")int[] tags,ModelMap model){

        int result = service.setMyInterest(username,tags);
        model.addAttribute("tags",service.getTags());
        model.addAttribute("mytags",service.showMyTags(username));

        if(result == 1){
            model.addAttribute("result","添加成功");
        }else{
            model.addAttribute("result","请勿重复添加！");
        }


        return "myInterestTags";
    }

    @RequestMapping("/deleteMyTags")
    public String deleteMyTags(@RequestParam("username")String username,
                               @RequestParam("id")int id,ModelMap model){

        int result = service.deleteMyTags(id);

        if(result == 1){
            model.addAttribute("result","删除成功！");
        }else{
            model.addAttribute("result","删除失败！");
        }

        model.addAttribute("tags",service.getTags());
        model.addAttribute("mytags",service.showMyTags(username));


        return "myInterestTags";
    }

    @RequestMapping("/adminIndex")
    public String adminIndex(@RequestParam(value="username",required=false)String username,ModelMap model){
        //model.addAttribute("username",username);
        //System.out.println("正访问管理员首页用户："+username);
        return "adminIndex";
    }

    @RequestMapping("/PersonalCenter")
    public String PersonalCenter(){
        return "PersonalCenter";
    }
    /**
     * 发送系统验证
     *
     * @param toEmailAddress 收件人邮箱
     * @return
     */
    @RequestMapping(value={"/sendEmailSystem"},method={RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String sendEmailSystem(@RequestParam("toEmailAddress") String toEmailAddress,HttpServletRequest request){
        try{
            //生成验证码
            int idcode = (int) (Math.random()*1000000);
            String verifyCode = Integer.toString(idcode);;

            //邮件主题
            String emailTitle = "【退役士兵网站】邮箱验证";

            //邮件内容
            String emailContent = "您正在【退役士兵网站】进行邮箱验证，您的验证码为：" + verifyCode + "，请于10分钟内完成验证！";
            request.getSession().setAttribute("idcode",verifyCode);
            //发送邮件
            SendmailUtil.sendEmail(toEmailAddress, emailTitle, emailContent);
            return CalculatorUtil.getJSONString(0,verifyCode);
        }catch(Exception e){
            return CalculatorUtil.getJSONString(1,"邮件发送失败！");
        }
    }
}
