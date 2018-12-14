package com.CourseManage.dao;

import com.CourseManage.pojo.Answer;

import java.util.HashMap;
import java.util.List;

public interface AnswerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Answer record);

    int insertSelective(Answer record);

    Answer selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Answer record);

    int updateByPrimaryKey(Answer record);

    List<Answer> selectByQuestionId(HashMap<String,Object>map);

    int deleteAllByQuesId(Integer quesid);

    int selectAnswerCount(Integer quesId);
}