package com.ResourceManage.dao;

import com.ResourceManage.pojo.UserOwnedResources;

import java.util.HashMap;
import java.util.List;

public interface UserOwnedResourcesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserOwnedResources record);

    int insertSelective(UserOwnedResources record);

    UserOwnedResources selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserOwnedResources record);

    int updateByPrimaryKey(UserOwnedResources record);

    int selectCount(String username);

    List<UserOwnedResources> selectByKeyWordsByPage(HashMap<String, Object> map);

    int checkUserOwn(HashMap<String, Object> map);

    int selectScore(HashMap<String, Object> map);

    int countTimes(HashMap<String, Object> map);

    int countScore(HashMap<String, Object> map);

    UserOwnedResources selectByWords(HashMap<String, Object> map);
}