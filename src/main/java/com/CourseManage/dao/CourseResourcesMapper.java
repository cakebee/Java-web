package com.CourseManage.dao;

import com.CourseManage.pojo.CourseResources;

import java.util.HashMap;
import java.util.List;

public interface CourseResourcesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseResources record);

    int insertSelective(CourseResources record);

    CourseResources selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseResources record);

    int updateByPrimaryKey(CourseResources record);

    int selectCourseResourceCount(int courseid);

    List<CourseResources> selectCourseResourceByPage(HashMap<String,Object> map);

    int selectPassCourseResources(int courseid);

    List<CourseResources> selectPassCourseResourceByPage(HashMap<String,Object> map);

    int selectCount();

    List<CourseResources> selectByPage(HashMap<String,Object> map);

    int updateflagByid1(Integer id);

    int updateflagByid2(Integer id);

    List<CourseResources> selectPassCourseResource(Integer courseid);

}