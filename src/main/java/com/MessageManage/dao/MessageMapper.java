package com.MessageManage.dao;

import com.MessageManage.pojo.Message;

import java.util.HashMap;
import java.util.List;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<Message> selectAllByReceId(HashMap<String,Object> map);

    List<Message> selectAllBySendId(HashMap<String,Object> map);

    int selectReceCount(String receID);

    int selectSendCount(String sendID);
}