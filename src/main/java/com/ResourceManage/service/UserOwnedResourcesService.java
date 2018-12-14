package com.ResourceManage.service;

import com.ResourceManage.dao.UserOwnedResourcesMapper;
import com.ResourceManage.pojo.UserOwnedResources;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class UserOwnedResourcesService {

    @javax.annotation.Resource
    private UserOwnedResourcesMapper userOwnedResourcesMapper;

    /*添加已购买资源*/
    public int addResource(UserOwnedResources userOwnedResources){
        return userOwnedResourcesMapper.insert(userOwnedResources);
    }

    /*查询当前用户拥有的资源*/
    public PageBean<UserOwnedResources> selectResourceByPage(int currentPage, String keyword){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("keyword",keyword);
        PageBean<UserOwnedResources> pageBean = new PageBean<UserOwnedResources>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = userOwnedResourcesMapper.selectCount(keyword);
        //System.out.println("count:"+totalCount);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<UserOwnedResources> lists = userOwnedResourcesMapper.selectByKeyWordsByPage(map);
        pageBean.setLists(lists);

        return pageBean;
    }

    /*查询用户是否拥有某资源*/
    public int checkUserOwn(String username,int resourceID){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("Username",username);
        map.put("ResourceID",resourceID);
        return userOwnedResourcesMapper.checkUserOwn(map);
    }

    /*查询某用户对某资源的打分*/
    public int selectScore(String username,int resourceID){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("Username",username);
        map.put("ResourceID",resourceID);
        return userOwnedResourcesMapper.selectScore(map);
    }

    /*返回某资源被评论的次数*/
    public int countTimes(int id){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("ResourceID",id);
        return userOwnedResourcesMapper.countTimes(map);
    }

    /*返回某资源的总分*/
    public int countScore(int id){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("ResourceID",id);
        return userOwnedResourcesMapper.countScore(map);
    }

    /*通过resourceid和username返回实体*/
    public UserOwnedResources selectByID(int id,String username){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("resourceID",id);
        map.put("username",username);
        return userOwnedResourcesMapper.selectByWords(map);
    }

    /*更新*/
    public int updateByPrimaryKey(UserOwnedResources userOwnedResources) {
        return userOwnedResourcesMapper.updateByPrimaryKey(userOwnedResources);
    }
}
