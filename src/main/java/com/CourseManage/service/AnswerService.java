package com.CourseManage.service;

import com.CourseManage.dao.AnswerMapper;
import com.CourseManage.pojo.Answer;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class AnswerService {
    @Resource
    private AnswerMapper answerMapper;

    public PageBean<Answer> getAllAnswers(int questionId, int currentPage){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<Answer> pageBean = new PageBean<Answer>();
        List<Answer> answersList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();
        totalCount = answerMapper.selectAnswerCount(questionId);

        tc = totalCount;
        num = Math.ceil(tc/pageSize);

        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(num.intValue());
        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("questionId", questionId);

        answersList = answerMapper.selectByQuestionId(map);
        pageBean.setLists(answersList);

        return pageBean;
    }

    public int addNewAnswer(Answer answer){
        return answerMapper.insert(answer);
    }

    public int delAnswer(Answer answer){
        return answerMapper.deleteByPrimaryKey(answer.getId());
    }

    public int delQuestionAnswers(int questionId){
        return answerMapper.deleteAllByQuesId(questionId);
    }

    public Answer getAnswer(int answerId){
        return answerMapper.selectByPrimaryKey(answerId);
    }
}
