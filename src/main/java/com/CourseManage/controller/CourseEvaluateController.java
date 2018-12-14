package com.CourseManage.controller;

import com.CourseManage.pojo.CourseEvaluate;
import com.CourseManage.service.CourseEvaluateService;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.UserManage.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class CourseEvaluateController {
    @Resource
    private CourseEvaluateService service;
    @Resource
    private HttpServletRequest request;
    @Resource
    private UserService userService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private CourseNoticeService courseNoticeService;

    //记录当前访问页
    private int Page;
    //记录评价的课程id，以便查询
    private int courseid;
    /*
        分页查询
    */
    //课程评价页面，包括展示所有评价和提交自身评价
    //首次进入的控制器
    @RequestMapping("/CourseEvaluate")
    public ModelAndView showCourseEvaluateList(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,@RequestParam(value = "courseID")int courseID ,Model model){

        courseid=courseID;
        Page = currentPage;
        ModelAndView modelandview = new ModelAndView("CourseEvaluate", "command", new CourseEvaluate());
        model.addAttribute("pagemsg", service.showCourseEvaluateListByPage(currentPage,courseID));//回显分页数据
        model.addAttribute("courseID",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        model.addAttribute("course",courseManageService.showCourse(courseID));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        return modelandview;
    }
    //点击下一页或其他按钮切换时进入的控制器
    @RequestMapping("/CourseEvaluate1")
    public ModelAndView showCourseEvaluate1List(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage ,Model model){

        Page = currentPage;
        ModelAndView modelandview = new ModelAndView("CourseEvaluate", "command", new CourseEvaluate());
        model.addAttribute("pagemsg", service.showCourseEvaluateListByPage(currentPage,courseid));//回显分页数据
        model.addAttribute("courseID",courseid);

        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return modelandview;
    }
    //提交评价并刷新页面
    @RequestMapping(value = "/CourseEvaluateCommit",method = RequestMethod.POST)
    public ModelAndView dopost(@ModelAttribute("command")CourseEvaluate courseEvaluate, HttpSession session, ModelMap model){
        ModelAndView modelandview;
        courseEvaluate.setCourseid(courseid);
        model.addAttribute("courseID",courseid);
        courseEvaluate.setUserid((String) session.getAttribute("username"));
        int result = service.insertCourseEvaluate(courseEvaluate);
        if(result == 1){
            modelandview = new ModelAndView("CourseEvaluate", "command", courseEvaluate);
            model.addAttribute("result", "提交成功");
            model.addAttribute("pagemsg", service.showCourseEvaluateListByPage(Page,courseid));//回显分页数据
            //TODO:3s后跳转到原界面
            //model.addAttribute("url", "login");
        }else{
            modelandview = new ModelAndView("CourseEvaluate", "command",courseEvaluate);
            model.addAttribute("result", "提交失败请重新提交");
            model.addAttribute("pagemsg", service.showCourseEvaluateListByPage(Page,courseid));//回显分页数据
            //TODO:3s后跳转到源界面

        }

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return modelandview;
    }
}
