package com.Administrator.dao;

import com.Administrator.pojo.Notice;

import java.util.HashMap;
import java.util.List;

public interface NoticeMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteNotice(Integer id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    int selectCount();

    List<Notice> selectByPage(HashMap<String, Object> map);
}