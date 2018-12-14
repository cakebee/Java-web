package com.CourseManage.dao;

import com.CourseManage.pojo.CourseNotice;

import java.util.HashMap;
import java.util.List;

public interface CourseNoticeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseNotice record);

    int insertSelective(CourseNotice record);

    CourseNotice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseNotice record);

    int updateByPrimaryKey(CourseNotice record);

    List<CourseNotice> selectAllByCourseId(HashMap<String,Object>map);

    int selectNoticeCount(Integer courseId);

    List<CourseNotice> selectLatestNotices(HashMap<String,Object> map);
}