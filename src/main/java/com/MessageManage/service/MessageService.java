package com.MessageManage.service;

import com.MessageManage.dao.MessageMapper;
import com.MessageManage.pojo.Message;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service("MessageService")
public class MessageService {
    @Resource
    private MessageMapper messageMapper;

    /*public List<Message> getReceMessageList(String username){
        List<Message> messageList;
        messageList = messageMapper.selectAllByReceId(username);
        return messageList;
    }*/

    public PageBean<Message> getMessageList(int currentPage, String userID, String type){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<Message> pageBean = new PageBean<Message>();
        List<Message> messageList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();

        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());

        if(type.equals("send")){
            totalCount = messageMapper.selectSendCount(userID);
            tc = totalCount;
            num = Math.ceil(tc/pageSize);
            pageBean.setTotalCount(totalCount);
            pageBean.setTotalPage(num.intValue());
            map.put("sendID", userID);
            messageList = messageMapper.selectAllBySendId(map);
        }else{
            totalCount = messageMapper.selectReceCount(userID);
            tc = totalCount;
            num = Math.ceil(tc/pageSize);
            pageBean.setTotalCount(totalCount);
            pageBean.setTotalPage(num.intValue());
            map.put("receID", userID);
            messageList = messageMapper.selectAllByReceId(map);
        }

        pageBean.setLists(messageList);

        return pageBean;
    }

    /*public List<Message> getSendMessageList(int currentPage, String userID){
        List<Message> messageList;

        messageList = messageMapper.selectAllBySendId(username);
        return messageList;
    }*/

    public int send(Message message){
        messageMapper.insert(message);
        return 0;
    }

    public String deleteMessage(Message message){
        messageMapper.deleteByPrimaryKey(message.getId());
        return "OK";
    }

    public String delReceMessage(Message message){
        message.setReceiver((byte)1);
        if(message.getReceiver()==(byte)1 && message.getSender()==1){
            messageMapper.deleteByPrimaryKey(message.getId());
        }else {
            messageMapper.updateByPrimaryKey(message);
        }
        return "OK";
    }

    public String delSendedMessage(Message message){
        message.setSender((byte)1);
        if(message.getReceiver()==(byte)1 && message.getSender()==1){
            messageMapper.deleteByPrimaryKey(message.getId());
        }else {
            messageMapper.updateByPrimaryKey(message);
        }
        return "OK";
    }

    public Message getSingleMessage(int messageId) {
        Message singleMessage = messageMapper.selectByPrimaryKey(messageId);
        return singleMessage;
    }

    public String setReaded(Message message){
        message.setFlag((byte)1);
        messageMapper.updateByPrimaryKey(message);
        return "OK";
    }
}
