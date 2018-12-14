package com.CourseManage.controller;

import com.CourseManage.pojo.Answer;
import com.CourseManage.pojo.Question;
import com.CourseManage.service.AnswerService;
import com.CourseManage.service.CourseNoticeService;
import com.CourseManage.service.QuestionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class AnswerController {
    @Resource
    private AnswerService answerService;
    @Resource
    private QuestionService questionService;
    @Resource
    private CourseNoticeService courseNoticeService;

    /*
        参数：Answer newAnswer
        描述：填充newAnswer，插入到数据库answer表中
        返回：“result”//执行情况
     */
    @RequestMapping("/addAnswer")
    public ModelAndView addAnswer(@RequestParam(value = "questionId")int questionId,
                                  @ModelAttribute("SpringWeb")Answer newAnswer,
                                  HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView("redirect:/getQuestion?questionId="+questionId);
        Question question = questionService.getQuestion(questionId);
        int courseID = question.getCourseid();
        HttpSession session = request.getSession();
        int result;//answerService添加消息的返回结果

        //设置新回答newAnswer的时间、用户名、问题id字段
        newAnswer.setAnswtime(new Date());//设置回答时间
        newAnswer.setUserid((String) session.getAttribute("username"));//设置用户名
        newAnswer.setQuesid(questionId);//设置问题ID

        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        result = answerService.addNewAnswer(newAnswer);
        if(result == 0){
            modelAndView.addObject("result","添加回答失败！");//插入数据库失败
        }else{
            modelAndView.addObject("result","添加成功！");
        }
        return modelAndView;
    }

    @RequestMapping("/delAnswer")
    public ModelAndView delAnswer(@RequestParam("answerId")int answerId,
                                  HttpServletRequest request) {
        HttpSession session = request.getSession();
        Answer answer = answerService.getAnswer(answerId);
        String username = (String)session.getAttribute("username");
        int questionId = answer.getQuesid();
        int courseID = questionService.getQuestion(questionId).getCourseid();
        ModelAndView modelAndView = new ModelAndView("redirect:/getQuestion?questionId="+questionId);
        modelAndView.addObject("courseNotices", courseNoticeService.getLatestNotices(courseID, 3));

        if(answer.getUserid().equals(username)){
            if(answerService.delAnswer(answer) == 0){
                modelAndView.addObject("result","删除失败");
            }else{
                modelAndView.addObject("result","删除成功");
            }
        }else{
            modelAndView.addObject("result","删除失败，没有权限");
        }
        return modelAndView;
    }
}
