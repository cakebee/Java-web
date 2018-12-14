package com.CourseManage.controller;

import com.CourseManage.pojo.Answer;
import com.CourseManage.pojo.Question;
import com.CourseManage.service.AnswerService;
import com.CourseManage.service.CourseManageService;
import com.CourseManage.service.CourseNoticeService;
import com.CourseManage.service.QuestionService;
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
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class QuestionController {

    @Resource
    private QuestionService questionService;
    @Resource
    private AnswerService answerService;
    @Resource
    private UserService userService;
    @Resource
    private CourseManageService courseManageService;
    @Resource
    private CourseNoticeService courseNoticeService;


    /*
        参数：courseId
        描述：显示一个课程下的所有问题列表，不包含问题的内容content
    */
    @RequestMapping(value = "/allQuestions", method = RequestMethod.GET)
    public ModelAndView getAllQuestionsSummary(@RequestParam(value = "courseId") int courseID,
                                               @RequestParam(value = "currentPage", defaultValue = "1")int currentPage){
        PageBean<Question> questionsSummaryList = questionService.getQuestionsSummary(courseID, currentPage);
        ModelAndView modelAndView = new ModelAndView("/coursePage/allQuestionsSummary","pagemsg", questionsSummaryList);
        modelAndView.addObject("courseId", courseID);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseID));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseID).getTeacher()));
        return modelAndView;
    }

    /*
        描述：获取当前用户的所有课程下的问题
     */
    @RequestMapping(value = "/myQuestion", method = RequestMethod.GET)
    public ModelAndView getMyQuestions(@RequestParam(value = "currentPage", defaultValue = "1", required = false)int currentPage,
                                       HttpServletRequest request,
                                       @RequestParam(value = "courseId")int courseId){
        HttpSession session = request.getSession();
        String userName = (String)session.getAttribute("username");
        PageBean<Question> questionsList = questionService.getUserQuestions(userName, currentPage);
        ModelAndView modelAndView = new ModelAndView("/coursePage/myQuestion","pagemsg",questionsList);
        modelAndView.addObject("courseId", courseId);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseId, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseId));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseId).getTeacher()));

        return modelAndView;
    }

    /*
        参数：courseId
        描述：编辑问题
     */
    @RequestMapping(value = "/editQuestion", method = RequestMethod.GET)
    public ModelAndView editQuestion(@RequestParam(value = "courseId")int courseId){
        Question question = new Question();
        question.setCourseid(courseId);
        ModelAndView modelAndView = new ModelAndView("/coursePage/editQuestion", "question", question);

        modelAndView.addObject("courseId", courseId);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseId, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseId));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseId).getTeacher()));

        return modelAndView;
    }

    /*
        添加一个问题，添加后重定向到/myQuestion
        返回结果result
     */
    @RequestMapping(value = "/addQuestion", method = RequestMethod.POST)
    public ModelAndView addQuestion(@ModelAttribute("SpringWeb")Question question,
                                    @RequestParam("courseId")int courseId,
                                    HttpServletRequest request){
        HttpSession session = request.getSession();
        ModelAndView modelAndView = new ModelAndView("redirect:/allQuestions?courseId="+courseId);
        int result;

        question.setUserid((String)session.getAttribute("username"));//添加问题的发送用户名
        question.setQuestime(new Date());//添加问题的时间
        question.setCourseid(courseId);//添加课程id
        result = questionService.addQuestion(question);

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseId, 3));
        modelAndView.addObject("course",courseManageService.showCourse(courseId));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(courseId).getTeacher()));

        if(result == 0){
            modelAndView.addObject("result", "添加问题失败");
        }else{
            modelAndView.addObject("result", "添加问题成功");
        }

        return modelAndView;
    }
    /*
        参数：questionId
        描述：显示一个问题的详情页面以及相应的回答
        返回question answers
     */
    @RequestMapping(value = "/getQuestion", method = RequestMethod.GET)
    public ModelAndView getQuestion(@RequestParam(value = "questionId")int questionId,
                                    @RequestParam(value = "currentPage",defaultValue = "1",required = false)int currentPage){
        Question question = questionService.getQuestion(questionId);
        PageBean<Answer> answers = answerService.getAllAnswers(questionId, currentPage);
        int courseID = question.getCourseid();
        ModelAndView modelAndView = new ModelAndView("/coursePage/question");

        modelAndView.addObject("question",question);//问题本体
        modelAndView.addObject("pagemsg", answers);//该问题下的回答
        modelAndView.addObject("newAnswer",new Answer());//待发送的回答，需要访问该问题的用户编辑后提交到/addAnswer

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(question.getCourseid()));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(question.getCourseid()).getTeacher()));

        return modelAndView;
    }

    /*
        参数：questionId
        描述：删除当前用户下的一个问题
        返回：删除结果
     */
    @RequestMapping(value = "/delQuestion", method = RequestMethod.GET)
    public ModelAndView delQuestion(@RequestParam(value = "questionId")int questionId, HttpServletRequest request){
        HttpSession session = request.getSession();
        Question question = questionService.getQuestion(questionId);
        int courseID = question.getCourseid();
        ModelAndView modelAndView = new ModelAndView("redirect:/myQuestion?courseId="+question.getCourseid());

        if(session.getAttribute("username").equals(question.getUserid())){
            if(questionService.delQuestion(question) == 0){
                modelAndView.addObject("result","删除问题失败");
            }else {
                answerService.delQuestionAnswers(questionId);
                modelAndView.addObject("result","删除问题成功");
            }
        }else{
            modelAndView.addObject("result", "删除失败，无权限");
        }

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));
        modelAndView.addObject("course",courseManageService.showCourse(question.getCourseid()));
        modelAndView.addObject("teacher",userService.selectByUsername(courseManageService.showCourse(question.getCourseid()).getTeacher()));

        return modelAndView;
    }

}
