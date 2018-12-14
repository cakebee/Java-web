package com.UserManage.dao;

import com.UserManage.pojo.Tag;

import java.util.List;

public interface TagMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tag record);

    int insertSelective(Tag record);

    Tag selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tag record);

    int updateByPrimaryKey(Tag record);

    List<Tag> selectAllTags();

    int updateCitedNumByPrimaryKey(int id);

    int decreaseCitedNumByPrimaryKey(int id);

    int selectTagPK(String tagname);


}