package com.CourseManage.dao;

import com.CourseManage.pojo.CourseIndex;

import java.util.List;

public interface CourseIndexMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseIndex record);

    int insertSelective(CourseIndex record);

    CourseIndex selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseIndex record);

    int updateByPrimaryKey(CourseIndex record);

    List<CourseIndex> selectByCourseID(Integer courseID);

    void updateVideoByPK(CourseIndex courseIndex);

    void updatePDFByPK(CourseIndex courseIndex);

    void updateWordByPK(CourseIndex courseIndex);

    CourseIndex selectByCourseIDChapterPart(CourseIndex courseIndex);

    List<CourseIndex> selectByVideoID(Integer videoID);
}