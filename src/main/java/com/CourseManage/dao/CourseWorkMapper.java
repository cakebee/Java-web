package com.CourseManage.dao;

import com.CourseManage.pojo.CourseWork;

import java.util.List;

public interface CourseWorkMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseWork record);

    int insertSelective(CourseWork record);

    CourseWork selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseWork record);

    int updateByPrimaryKey(CourseWork record);

    List<CourseWork> selectByCourseIDOrderChapterPart(Integer courseID);
}