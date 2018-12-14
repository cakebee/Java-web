package com.CourseManage.dao;

import com.CourseManage.pojo.CourseImage;

public interface CourseImageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseImage record);

    int insertSelective(CourseImage record);

    CourseImage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseImage record);

    int updateByPrimaryKeyWithBLOBs(CourseImage record);

    int updateByPrimaryKey(CourseImage record);

    int updateCourseImageByCourseid(CourseImage courseImage);

    CourseImage selectBycourseid(int courseid);
}