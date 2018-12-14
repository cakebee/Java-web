package com.CourseManage.controller;

import com.CourseManage.pojo.CourseWork;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.CourseManage.service.CourseWorkService;
import com.CourseManage.service.WorkScoreService;
import com.UserManage.service.UserService;
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
import java.util.List;

@Controller
public class CourseWorkController {
    @Resource
    private CourseWorkService courseWorkService;
    @Resource
    private WorkScoreService workScoreService;
    @Resource
    private UserService userService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private CourseNoticeService courseNoticeService;

    /*
        描述：查看某课程下的老师发布的所有作业题
        参数：课程ID
     */
    @RequestMapping(value = "/workList", method = RequestMethod.GET)
    public ModelAndView getWorkList(@RequestParam(value = "courseID")int courseID,
                                    HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView("/courseWorkPage/workList");
        List<CourseWork> workList = courseWorkService.getWorksList(courseID);
        boolean[] isSubmitList = new boolean[workList.size()];//学生每个作业的提交状态
        int[] scoreList = new int[workList.size()];//学生每个作业的得分
        HttpSession session = request.getSession();
        String userID = (String)session.getAttribute("username");

        //检索当前学生每个作业是否已经提交
        if(workList.size()!=0){
            for(int i=0; i<workList.size(); i++){
                isSubmitList[i] = workScoreService.isSubmit(workList.get(i).getId(), userID);
                scoreList[i] = workScoreService.getScore(workList.get(i).getId(), userID);
            }
            modelAndView.addObject("isSubmitList", isSubmitList);
            modelAndView.addObject("score", scoreList);
        }

        modelAndView.addObject("workList", workList);
        modelAndView.addObject("courseID",courseID);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));


        return modelAndView;
    }

    /*
        描述：编辑一个新的作业
        参数：课程ID
     */
    @RequestMapping(value = "/newWork", method = RequestMethod.GET)
    public ModelAndView newWork(@RequestParam("courseID")int courseID){
        ModelAndView modelAndView = new ModelAndView("/courseWorkPage/newWork");
        modelAndView.addObject("command", new CourseWork());
        modelAndView.addObject("courseID",courseID);
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        return modelAndView;
    }

    /*
        描述：将编辑好的作业插入到数据库中
        参数：CourseWork couseWork //作业对象
            MultipartFile file //作业文件
     */
    @RequestMapping(value = "/addWork", method = RequestMethod.POST)
    public ModelAndView addWork(@ModelAttribute("SpringWeb")CourseWork courseWork,
                                @RequestParam("file")MultipartFile file,
                                @RequestParam("courseID")int courseID)throws Exception{
        ModelAndView modelAndView = new ModelAndView("redirect:/workList?courseID="+courseID);
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        courseWork.setCourseid(courseID);
        int result = courseWorkService.addWork(courseWork,file);

        if(result != 0){
            modelAndView.addObject("result","添加失败");
        }
        return modelAndView;
    }

    /*
        描述：下载老师发布的作业
        参数：作业id
     */
    @RequestMapping(value = "/downloadWork",method = RequestMethod.GET)
    public ResponseEntity<byte[]> downloadWork(@RequestParam("workID")int workID) throws IOException {
        return courseWorkService.downloadWork(workID);
    }

    /*
        描述：删除一个作业，包括作业题文件、该作业下的所有学生提交的作业
     */
    @RequestMapping(value = "/delWork",method = RequestMethod.GET)
    public ModelAndView delWork(@RequestParam("workID")int workID,
                                @RequestParam("courseID")int courseID)throws IOException{
        ModelAndView modelAndView = new ModelAndView("redirect:/workList?courseID="+courseID);
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        courseWorkService.delWork(workID);

        return modelAndView;
    }
}
