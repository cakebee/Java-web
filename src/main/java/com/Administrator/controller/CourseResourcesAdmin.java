package com.Administrator.controller;

import com.Administrator.service.CourseResourcesAdminService;
import com.CourseManage.pojo.Course;
import com.CourseManage.service.CourseManageService;
import com.MessageManage.pojo.Message;
import com.MessageManage.service.MessageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class CourseResourcesAdmin {
    @Resource
    private CourseResourcesAdminService service;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private MessageService messageService;
    @Resource
    private HttpServletRequest request;
    //记录当前页
    private int Page;
    /*
        分页查询
    */
    //待审核的资源列表
    @RequestMapping("/showCourseResourcesList")
    public String showCourseResourceList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage, Model model){
        System.out.println("11"+currentPage);
        model.addAttribute("pagemsg", service.showCourseResourcesListByPage(currentPage));//回显分页数据
        Page = currentPage;
        //String username=(String)request.getAttribute("username");
        request.setAttribute("username","root");
        //System.out.println("11"+username);
        return "showCourseResourcesList";
    }

    /*
    审核资源
     */
    //通过
    @RequestMapping("/adminCourseResourceSuccess")
    public ModelAndView adminSuccess(@RequestParam("id") int id,@RequestParam("courseID") int courseid,@RequestParam("name") String name,@RequestParam("filename") String filename, Model model){
        service.updateflagByid1(id);
        Course course = courseManageService.showCourse(courseid);
        String receiveid = course.getTeacher();
        Message message = new Message();
        message.setReceid(receiveid);
        message.setSendid("admin");
        message.setContent("courseid:"+courseid+"\n"+"name:"+name+"\n"+"filename:"+filename+"\n"+"通过");
        message.setTitle("审核结果");
        message.setFlag((byte)0);//设置未读
        message.setSender((byte)0);//设置发送方发件箱中该消息未删除
        message.setReceiver((byte)0);//设置接收方收件箱中该消息未删除
        message.setSendtime(new Date());//设置消息发送时间
        messageService.send(message);
        ModelAndView modelAndView = new ModelAndView("showCourseResourcesList","result","通过");
        model.addAttribute("pagemsg", service.showCourseResourcesListByPage(Page));//回显分页数据
        request.setAttribute("username","root");
        return modelAndView;

    }
    //不通过
    @RequestMapping("/adminCourseResourceFailed")
    public ModelAndView adminFailed(@RequestParam("id") int id,@RequestParam("courseID") int courseid,@RequestParam("name") String name,@RequestParam("filename") String filename,Model model){
        service.updateflagByid2(id);
        Course course = courseManageService.showCourse(courseid);
        String receiveid = course.getTeacher();
        Message message = new Message();
        message.setReceid(receiveid);
        message.setSendid("admin");
        message.setContent("courseid:"+courseid+"\n"+"name:"+name+"\n"+"filename:"+filename+"\n"+"未通过");
        message.setTitle("审核结果");
        message.setFlag((byte)0);//设置未读
        message.setSender((byte)0);//设置发送方发件箱中该消息未删除
        message.setReceiver((byte)0);//设置接收方收件箱中该消息未删除
        message.setSendtime(new Date());//设置消息发送时间
        messageService.send(message);
        ModelAndView modelAndView = new ModelAndView("showCourseResourcesList","result","未通过");
        model.addAttribute("pagemsg",service.showCourseResourcesListByPage(Page));
        request.setAttribute("username","root");

        return modelAndView;
    }
}
