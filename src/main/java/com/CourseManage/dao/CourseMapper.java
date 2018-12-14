package com.CourseManage.dao;

import com.CourseManage.pojo.Course;

import java.util.HashMap;
import java.util.List;

public interface CourseMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Course record);

    int insertSelective(Course record);

    Course selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    int selectCount(String teacher);

    int selectCountAll();

    int selectKeyCourseCount(String keywords);

    int selectKeyTeacherCount(String keywords);

    int selectKeyTypeCount(String keywords);

    int selectPassCourseCount();

    int selectMyInterestTypeCourseCount(List<String> list);

    List<Course> selectByPage(HashMap<String,Object> map);

    List<Course> selectAllByPage(HashMap<String,Object> map);

    List<Course> selectKeyCourseByPage(HashMap<String,Object> map);

    List<Course> selectKeyTeacherByPage(HashMap<String,Object> map);

    List<Course> selectPassCourseByPage(HashMap<String,Object> map);

    List<Course> selectTypeCourseByPage(HashMap<String,Object> map);

    List<Course> selectMyInterestTypeCourseByPage(HashMap<String,Object> map);

    int updateCourse(Course course);

    int selectCountadmin();

    List<Course> selectByPageadmin(HashMap<String,Object> map);

    int updateflagByid1(Integer id);

    int updateflagByid2(Integer id);

    List<Course> selectHotCourses(List<Integer> list);

}