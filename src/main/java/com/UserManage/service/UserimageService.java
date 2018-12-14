package com.UserManage.service;

import com.UserManage.dao.UserImageMapper;
import com.UserManage.pojo.UserImage;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserimageService {
    @Resource
    private UserImageMapper userImageMapper;
    public int insert(UserImage userImage){
        return userImageMapper.insert(userImage);
    }
    public UserImage selectByUserid(String userid){
        return userImageMapper.selectByUserid(userid);
    }
    public int updateByUserid(byte[] image,String username){
        UserImage userImage = new UserImage();
        userImage.setUserimage(image);
        userImage.setUserid(username);
        if (selectByUserid(userImage.getUserid())!=null){
            return userImageMapper.updateByUserid(userImage);
        }
        else {
            return insert(userImage);
        }
    }
}
