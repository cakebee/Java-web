package com.CourseManage.dao;

import com.CourseManage.pojo.Test_score;

import java.util.HashMap;
import java.util.List;

public interface Test_scoreMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Test_score record);

    int insertSelective(Test_score record);

    Test_score selectByPrimaryKey(Integer id);

    Test_score selectByStudentid(HashMap<String, Object> map);

    int updateByPrimaryKeySelective(Test_score record);

    int updateByPrimaryKey(Test_score record);

    int selectCount(int courseid);

    List<Test_score> selectByPage(HashMap<String, Object> map);

}