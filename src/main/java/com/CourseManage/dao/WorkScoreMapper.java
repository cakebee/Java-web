package com.CourseManage.dao;

import com.CourseManage.pojo.WorkScore;

import java.util.HashMap;
import java.util.List;

public interface WorkScoreMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(WorkScore record);

    int insertSelective(WorkScore record);

    WorkScore selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(WorkScore record);

    int updateByPrimaryKey(WorkScore record);

    List<WorkScore> selectByWorkID(HashMap<String,Object>map);

    int selectCountByWorkID(Integer workID);

    int deleteByWorkID(Integer workID);

    List<WorkScore> selectByWorkIDUserID(HashMap<String,Object>map);

    int updateFileByWorkIDUserID(WorkScore record);
}