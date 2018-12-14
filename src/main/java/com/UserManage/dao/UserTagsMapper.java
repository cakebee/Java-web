package com.UserManage.dao;

import com.UserManage.pojo.UserTags;

import java.util.HashMap;
import java.util.List;

public interface UserTagsMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(UserTags record);

    int insertSelective(UserTags record);

    UserTags selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserTags record);

    int updateByPrimaryKey(UserTags record);

    List<UserTags> selectMyTags(String username);

    UserTags selectMyExistedTags(HashMap<String,Object> map);

}