package com.CourseManage.controller;

import com.CourseManage.pojo.CourseWork;
import com.CourseManage.pojo.WorkScore;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.CourseManage.service.CourseWorkService;
import com.CourseManage.service.WorkScoreService;
import com.UserManage.service.UserService;
import com.Utils.Pagination.PageBean;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class WorkScoreController {
    @Resource
    private WorkScoreService workScoreService;
    @Resource
    private CourseWorkService courseWorkService;
    @Resource
    private UserService userService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private CourseNoticeService courseNoticeService;

    /*
        描述：获取一个作业下的所有学生作业列表
        参数：int workID   //作业ID
             int currentPage    //（分页）当前页面
             int courseID   //课程ID
     */
    @RequestMapping(value = "/allStuWorks", method = RequestMethod.GET)
    public ModelAndView getAllStuWorks(@RequestParam("workID")int workID,
                                       @RequestParam("courseID")int courseID,
                                       @RequestParam(value = "currentPage", defaultValue = "1", required = false)int currentPage){
        ModelAndView modelAndView = new ModelAndView("courseWorkPage/allStuWorks");
        PageBean<WorkScore> allStuWorksList = workScoreService.getStuWorks(workID,currentPage);

        modelAndView.addObject("pagemsg", allStuWorksList);
        modelAndView.addObject("workID", workID);
        modelAndView.addObject("courseID", courseID);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        return modelAndView;
    }

    /*
        描述：学生添加作业
     */
    @RequestMapping(value = "/newStuWork",method = RequestMethod.GET)
    public ModelAndView newStuWork(@RequestParam("workID")int workID,
                                   @RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("courseWorkPage/newStuWork");
        CourseWork work = courseWorkService.getWork(workID);
        WorkScore workScore = new WorkScore();

        workScore.setWorkid(workID);
        modelAndView.addObject("command", workScore);
        modelAndView.addObject("work", work);
        modelAndView.addObject("courseID", courseID);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        return modelAndView;
    }


    /*
        描述：接收学生添加的作业，在数据库中插入记录，并存放作业文件
     */
    @RequestMapping(value = "/addStuWork", method = RequestMethod.POST)
    public ModelAndView addStuWork(@ModelAttribute("SpringWeb")WorkScore workScore,
                                   @RequestParam("file")MultipartFile file,
                                   @RequestParam("courseID")int courseID,
                                   @RequestParam("workID")int workID,
                                   HttpServletRequest request) throws IOException{
        ModelAndView modelAndView = new ModelAndView("redirect:/workList?courseID=" + courseID);
        HttpSession session = request.getSession();
        String userID = (String )session.getAttribute("username");

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        workScore.setUserid(userID);
        workScore.setWorkid(workID);

        if(workScoreService.submitStuWork(workScore, file)){
            modelAndView.addObject("result", "上传成功");
        }else{
            modelAndView.addObject("result", "上传失败");
        }
        return modelAndView;
    }

    /*
        描述：下载一个学生的作业
        参数：int workScoreID
     */
    @RequestMapping(value = "/downloadStuWork", method = RequestMethod.GET)
    public ResponseEntity<byte[]> downloadStuWork(@RequestParam("workScoreID")int workScoreID) throws IOException {
        return workScoreService.downloadStuWork(workScoreID);
    }

    /*
        描述：老师给学生提交的一个作业打分
     */
    @RequestMapping(value = "/setScore", method = RequestMethod.POST)
    public ModelAndView setScore(@RequestParam("score")int score,
                                 @RequestParam("workScoreID")int workScoreID,
                                 @RequestParam("workID")int workID,
                                 @RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("redirect:/allStuWorks?workID=" + workID + "&courseID="+courseID);
        workScoreService.setScore(workScoreID, score);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));

        return modelAndView;
    }
}
