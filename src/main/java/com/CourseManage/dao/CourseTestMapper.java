package com.CourseManage.dao;

import com.CourseManage.pojo.CourseTest;

import java.util.HashMap;
import java.util.List;

public interface CourseTestMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CourseTest record);

    int insertSelective(CourseTest record);

    CourseTest selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CourseTest record);

    int updateByPrimaryKey(CourseTest record);

    int selectCount(int courseid);

    List<CourseTest> selectByPage(HashMap<String, Object> map);

    CourseTest selectByTestname(HashMap<String, Object> map);
}