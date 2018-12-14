package com.UserManage.dao;

import com.UserManage.pojo.UserImage;

public interface UserImageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserImage record);

    int insertSelective(UserImage record);

    UserImage selectByPrimaryKey(Integer id);
    UserImage selectByUserid(String userid);
    int updateByPrimaryKeySelective(UserImage record);

    int updateByPrimaryKeyWithBLOBs(UserImage record);

    int updateByPrimaryKey(UserImage record);

    int updateByUserid(UserImage record);
}