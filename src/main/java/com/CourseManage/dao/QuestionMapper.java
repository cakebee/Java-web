package com.CourseManage.dao;

import com.CourseManage.pojo.Question;

import java.util.HashMap;
import java.util.List;

public interface QuestionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKey(Question record);

    //查询该课程下的问题，包含标题title、发送者userid、发送时间questime
    List<Question> selectSummaryByCourseId(HashMap<String,Object>map);

    List<Question> selectByUserName(String userName);

    int selectQuestionCount(int courseID);

    int selectUserQuestionCount(String userName);

    List<Question> selectSummaryByUserName(HashMap<String,Object>map);
}