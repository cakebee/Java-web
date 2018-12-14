package com.CourseManage.controller;

import com.CourseManage.pojo.CourseTest;
import com.CourseManage.pojo.Test_score;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.CourseManage.service.CourseTestService;
import com.UserManage.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
public class CourseTestController {
    @Resource
    private CourseTestService courseTestService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private UserService userService;
    @Resource
    private CourseNoticeService courseNoticeService;

    //记录当前访问页
    private int Page;
    private int scorce;
    @RequestMapping("/addTest")
    public String addTest(@RequestParam("courseId")int courseid, Model model){
        model.addAttribute("courseid",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return "CourseTest";
    }

    @RequestMapping("/deteleTestindex")
    public String deteleTestindex(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,@RequestParam("courseId")int courseid, Model model){
        model.addAttribute("pagemsg", courseTestService.showCourseTestListByPage(currentPage,courseid));//回显分页数据
        model.addAttribute("courseid",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return "deteleTest";
    }

    @RequestMapping("/deteleTest")
    public String deteleTest(@RequestParam("testID")int testID,
                             @RequestParam("courseid")int courseid, Model model){
        /*int result = courseTestService.deteleTest(courseid,testname);*/
        int result = courseTestService.deteleTest(testID);
        model.addAttribute("pagemsg", courseTestService.showCourseTestListByPage(1,courseid));//回显分页数据
        model.addAttribute("courseid",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        if (result==1){
            model.addAttribute("result","成功");
        }else{
            model.addAttribute("result","失败");
        }
        return "Testindex";
    }

    @RequestMapping("/showTestscore")
    public String showTestscore(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,@RequestParam("courseId")int courseid, Model model){
        model.addAttribute("pagemsg", courseTestService.showScorceListByPage(currentPage,courseid));
        model.addAttribute("courseid",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return "showTestScore";
    }

    @RequestMapping("/CourseTest")
    public String CourseTest(@RequestParam("courseid")int courseid,
                             @RequestParam("testname")String testname,
                             @RequestParam("price")int price,
                             @RequestParam("questionA")String questionA,
                             @RequestParam("questionB")String questionB,
                             @RequestParam("questionC")String questionC,
                             @RequestParam("correct")String correct,
                             Model model){
        int result = courseTestService.insertTest(courseid,testname,price,questionA,questionB,questionC,correct,0);
        model.addAttribute("result",result);
        model.addAttribute("courseid",courseid);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return "CourseTest";
    }
    @RequestMapping("/Test")
    public String Test(@RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                       @RequestParam("type")String type,
                       @RequestParam("courseId")int courseid,
                       @RequestParam("username")String username,
                       Model model){
        model.addAttribute("pagemsg", courseTestService.showCourseTestListByPage(currentPage,courseid));//回显分页数据
        model.addAttribute("courseid",courseid);
        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        if (type.equals("teacher")){
            model.addAttribute("courseid",courseid);
            return "Testindex";
        }else{
            Test_score test_score = courseTestService.selectScore(courseid,username);
            if (test_score==null){
                model.addAttribute("flag",0);
            }else{
                model.addAttribute("flag",1);
                model.addAttribute("result",test_score.getScore());
            }
            model.addAttribute("courseid",courseid);
            scorce = 0;
            model.addAttribute("pagemsg", courseTestService.showCourseTestListByPage(currentPage,courseid));//回显分页数据
            Page = currentPage;
            return "Test";
        }
    }
    @RequestMapping("/catch")
    public ModelAndView answer(@RequestParam("courseid")int courseid,
                               @RequestParam("testname")String testname,
                               @RequestParam("studentname")String studentname,
                               @RequestParam("answer")String answer,
                               @RequestParam(value="currentPage",defaultValue="1",required=false)int currentPage,
                               Model model){
        ModelAndView modelAndView = new ModelAndView("Test");
        model.addAttribute("courseid",courseid);
        Page = currentPage;
        System.out.println(answer);
        CourseTest courseTest = courseTestService.select(courseid,testname);
        String op = courseTest.getOp();
        System.out.println(op);
        if (answer.equals(op)){
            scorce = scorce+courseTest.getPice();
        }
        if ((currentPage) == courseTestService.countTest(courseid)){
            model.addAttribute("result",scorce);
            courseTestService.insertScore(courseid,studentname,scorce);
            courseManageService.updataStuCourseScore(studentname,courseid,scorce);
        }
        model.addAttribute("pagemsg", courseTestService.showCourseTestListByPage(Page+1,courseid));//回显分页数据
        model.addAttribute("flag",0);

        model.addAttribute("courseNotices", courseNoticeService.getLatestNotices(courseid, 3));
        model.addAttribute("course",courseManageService.showCourse(courseid));
        model.addAttribute("teacher",userService.selectByUsername(courseManageService.showCourse(courseid).getTeacher()));

        return modelAndView;
    }



}
