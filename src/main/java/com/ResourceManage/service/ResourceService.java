package com.ResourceManage.service;

import com.ResourceManage.dao.ResourceMapper;
import com.ResourceManage.dao.UserOwnedResourcesMapper;
import com.ResourceManage.pojo.Resource;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;


/*
 * 资源service
 * 提供的功能：
 *      添加资源
 *      删除资源
 *      审核资源(修改资源的flage)
 *      浏览资源列表
 *      展示资源详情
 *      查找资源(根据关键词)
 * */
@Service("ResourceService")
public class ResourceService {

    @javax.annotation.Resource
    private ResourceMapper resourceMapper;

    @javax.annotation.Resource
    private UserOwnedResourcesMapper userOwnedResourcesMapper;


    /*添加资源*/
    public int addResource(Resource resource){
        return resourceMapper.insert(resource);
    }

    /*删除资源*/
    public int deleteResource(int id){
        Resource resource = resourceMapper.selectByPrimaryKey(id);
        if (resource!=null){
            return resourceMapper.deleteByPrimaryKey(id);
        }
        System.out.println("该资源不存在");
        return  0;
    }

    /*审核资源*/
    public int updateResource(Resource resource){
        return resourceMapper.updateByPrimaryKey(resource);
    }


    /*根据ID查询资源*/
    public Resource selectResourceByID(int id){
        Resource resource = resourceMapper.selectByPrimaryKey(id);
        if (resource==null){
            System.out.println("该资源不存在");
        }
        return resource;
    }

    public Object selectByPage(int currentPage, String keyword,int type) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("keyword",keyword);

        PageBean<Resource> pageBean = new PageBean<Resource>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        int totalCount=0;

        if (type==0)
            totalCount = resourceMapper.selectCount(map);
        if (type==1)
            totalCount = resourceMapper.selectCount1(map);
        if (type==2)
            totalCount = resourceMapper.selectCount2(map);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        List<Resource> lists=null;
        //封装每页显示的数据
        if (type==0)
            lists = resourceMapper.selectByKeyWordsByPage(map);
        if (type==1)
            lists = resourceMapper.Manage_selectByKeyWordsByPage(map);
        if (type==2)
            lists = resourceMapper.selectByUserNameByPage(map);
        pageBean.setLists(lists);

        return pageBean;
    }
}
