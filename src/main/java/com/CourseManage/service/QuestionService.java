package com.CourseManage.service;

import com.CourseManage.dao.QuestionMapper;
import com.CourseManage.pojo.Question;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class QuestionService {
    @Resource
    private QuestionMapper questionMapper;


    public PageBean<Question> getQuestionsSummary(int courseID,int currentPage){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<Question> pageBean = new PageBean<Question>();
        List<Question> questionsList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();
        totalCount = questionMapper.selectQuestionCount(courseID);

        tc = totalCount;
        num = Math.ceil(tc/pageSize);

        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(num.intValue());
        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseID", courseID);

        questionsList = questionMapper.selectSummaryByCourseId(map);
        pageBean.setLists(questionsList);

        return pageBean;
    }

    public Question getQuestion(int questionId){
        return questionMapper.selectByPrimaryKey(questionId);
    }

    public int delQuestion(Question question) {
        questionMapper.deleteByPrimaryKey(question.getId());
        return 0;
    }

    public int addQuestion(Question question){
        return questionMapper.insert(question);
    }

    public PageBean<Question> getUserQuestions(String userName, int currentPage){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<Question> pageBean = new PageBean<Question>();
        List<Question> questionsList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();
        totalCount = questionMapper.selectUserQuestionCount(userName);

        tc = totalCount;
        num = Math.ceil(tc/pageSize);

        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(num.intValue());
        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("userName", userName);

        questionsList = questionMapper.selectSummaryByUserName(map);
        pageBean.setLists(questionsList);

        return pageBean;
    }
}
