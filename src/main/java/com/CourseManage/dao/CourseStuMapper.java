package com.CourseManage.dao;

import com.CourseManage.pojo.CourseStu;
import com.CourseManage.pojo.stuScoreRank;

import java.util.HashMap;
import java.util.List;

public interface CourseStuMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteMyParticipateCourse(HashMap<String,Object> map);

    int insert(CourseStu record);

    int insertSelective(CourseStu record);

    CourseStu selectByPrimaryKey(Integer id);

    CourseStu checkMyParticipateCourse(CourseStu record);

    int updateByPrimaryKeySelective(CourseStu record);

    int updateScoreByUIDCourseID(HashMap<String,Object> map);

    int selectMyCourseScore(HashMap<String,Object> map);

    int updateByPrimaryKey(CourseStu record);

    int selectMyParticipateCourseCount(String username);

    List<CourseStu> selectMyParticipateCourseByPage(HashMap<String,Object> map);

    List<Integer> selectHotCourse();

    List<stuScoreRank> selectStuScoreRank(HashMap<String,Object> map);

    int selectStuScoreRankCount(int courseid);



}