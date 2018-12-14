package com.UserManage.dao;

import com.UserManage.pojo.User;

import java.util.HashMap;
import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectByUsername(String username);

    String check(String username);

    int selectCount();

    List<User> selectByPage(HashMap<String,Object> map);

    int updateByUsername(User user);

    int deleteByUsername(String username);

    int updateOthersByUsername(User user);

    int selectIntegralRank(String username);

    int updatePassByUsername(User user);


}