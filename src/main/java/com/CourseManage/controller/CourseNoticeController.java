package com.CourseManage.controller;

import com.CourseManage.pojo.CourseNotice;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.UserManage.service.UserService;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class CourseNoticeController {
    @Resource
    private CourseNoticeService courseNoticeService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private UserService userService;

    @RequestMapping(value = "/allNotices",method = RequestMethod.GET)
    public ModelAndView getAllCourseNoticeSummaries(@RequestParam("courseID")int courseID,
                                                    @RequestParam(value = "currentPage",defaultValue = "1", required = false)int currentPage){
        ModelAndView modelAndView = new ModelAndView("coursePage/allNoticeSummary");
        PageBean<CourseNotice> noticeSummaryList = courseNoticeService.getAllNoticeSummary(courseID, currentPage);
        String teacherID = courseManageService.showCourse(courseID).getTeacher();

        modelAndView.addObject("pagemsg", noticeSummaryList);
        modelAndView.addObject("courseID",courseID);
        modelAndView.addObject("teacher",userService.selectByUsername(teacherID));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        return modelAndView;
    }

    @RequestMapping(value = "/editNotice", method = RequestMethod.GET)
    public ModelAndView editNotice(@RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("coursePage/editNotice");

        modelAndView.addObject("courseID",courseID);
        modelAndView.addObject("command",new CourseNotice());
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        return modelAndView;
    }

    @RequestMapping(value = "/notice", method = RequestMethod.GET)
    public ModelAndView getNotice(@RequestParam("noticeId")int noticeId){
        ModelAndView modelAndView = new ModelAndView("/coursePage/notice");
        CourseNotice notice = courseNoticeService.getNotice(noticeId);
        int courseID = notice.getCourseid();

        modelAndView.addObject("courseID", courseID);
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("notice", notice);
        return modelAndView;
    }

    @RequestMapping(value = "/addNotice", method = RequestMethod.POST)
    public ModelAndView addNotice(@RequestParam("courseID")int courseID,
                                  @ModelAttribute("SpringWeb")CourseNotice newNotice,
                                  HttpServletRequest request){
        /*HttpSession session = request.getSession();
        String userType = (String)session.getAttribute("type");*/
        ModelAndView modelAndView = new ModelAndView("redirect:/allNotices?courseID="+courseID);

        newNotice.setTime(new Date());//设置时间
        newNotice.setCourseid(courseID);//设置课程号
        courseNoticeService.addNotice(newNotice);

        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("result","添加成功");

        return modelAndView;
    }

    @RequestMapping(value = "/delNotice", method = RequestMethod.GET)
    public ModelAndView delNotice(@RequestParam("noticeID")int noticeID,
                                  @RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("redirect:/allNotices?courseID="+courseID);

        courseNoticeService.delNotice(noticeID);

        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("result","删除成功");

        return modelAndView;
    }

    @RequestMapping(value = "/reEditNotice",method = RequestMethod.GET)
    public ModelAndView reEditNotice(@RequestParam("noticeID")int noticeID,
                                     @RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("/coursePage/reEditNotice");

        CourseNotice oldNotice = courseNoticeService.getNotice(noticeID);

        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("command",oldNotice);
        modelAndView.addObject("courseID",courseID);

        return modelAndView;
    }

    @RequestMapping(value = "/updateNotice",method = RequestMethod.POST)
    public ModelAndView updateNotice(@ModelAttribute("SpringWeb")CourseNotice notice,
                                     @RequestParam("courseID")int courseID,
                                     @RequestParam("noticeID")int noticeID){
        ModelAndView modelAndView = new ModelAndView("redirect:/allNotices?courseID="+courseID);
        notice.setCourseid(courseID);
        notice.setId(noticeID);
        courseNoticeService.updateNotice(notice);
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("result", "修改成功");
        return modelAndView;
    }
}
