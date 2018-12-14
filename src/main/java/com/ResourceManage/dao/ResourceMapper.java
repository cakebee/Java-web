package com.ResourceManage.dao;

import com.ResourceManage.pojo.Resource;

import java.util.HashMap;
import java.util.List;

public interface ResourceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Resource record);

    int insertSelective(Resource record);

    Resource selectByPrimaryKey(Integer id);

    int selectCount(HashMap<String, Object> map);

    int selectCount1(HashMap<String, Object> map);

    int selectCount2(HashMap<String, Object> map);

    List<Resource> selectByPage(HashMap<String, Object> map);

    Resource selectByUserid(String userid);

    int updateflagByid1(Integer id);

    int updateflagByid2(Integer id);

    int updateByPrimaryKeySelective(Resource record);

    int updateByPrimaryKey(Resource record);

    List<Resource> selectByKeyWordsByPage(HashMap<String, Object> map);

    List<Resource> Manage_selectByKeyWordsByPage(HashMap<String, Object> map);

    List<Resource> selectByUserNameByPage(HashMap<String, Object> map);

}