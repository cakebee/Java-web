package com.Administrator.service;

import com.ResourceManage.dao.ResourceMapper;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class adminService {
    @Resource
    private ResourceMapper resourceMapper;
    /*
    用户表的记录总数
 */
    public int countUser(){
        return resourceMapper.selectCount(null);
    }
    /*
    分页查询
 */
    public PageBean<com.ResourceManage.pojo.Resource> showResourceListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<com.ResourceManage.pojo.Resource> pageBean = new PageBean<com.ResourceManage.pojo.Resource>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = resourceMapper.selectCount(null);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<com.ResourceManage.pojo.Resource> lists = resourceMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }

    public Resource selectByUserid(String userid){
        return (Resource) resourceMapper.selectByUserid(userid);
    }
    public int updateflagByid1(int id){return resourceMapper.updateflagByid1(id);}
    public int updateflagByid2(int id){return resourceMapper.updateflagByid2(id);}
}
