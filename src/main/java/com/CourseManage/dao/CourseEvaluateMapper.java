package com.CourseManage.dao;

import com.CourseManage.pojo.CourseEvaluate;

import java.util.HashMap;
import java.util.List;

public interface CourseEvaluateMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseEvaluate record);

    int insertSelective(CourseEvaluate record);

    CourseEvaluate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseEvaluate record);

    int updateByPrimaryKey(CourseEvaluate record);

    int selectCount(Integer courseid);

    List<CourseEvaluate> selectByPage(HashMap<String, Object> map);
}