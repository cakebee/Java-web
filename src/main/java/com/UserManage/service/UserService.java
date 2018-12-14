package com.UserManage.service;

import com.UserManage.dao.TagMapper;
import com.UserManage.dao.UserMapper;
import com.UserManage.dao.UserTagsMapper;
import com.UserManage.pojo.Tag;
import com.UserManage.pojo.User;
import com.UserManage.pojo.UserImage;
import com.UserManage.pojo.UserTags;
import com.Utils.Data.PathData;
import com.Utils.Pagination.PageBean;
import com.Utils.SendmailUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("UserService")
public class UserService {
    @Resource
    private UserMapper userMapper;
    @Resource
    private TagMapper tagMapper;
    @Resource
    private UserTagsMapper userTagsMapper;
    @Resource
    private PathData pathData;
    @Resource
    private UserimageService userimageService;
    /*
        查询用户注册情况，返回值为用户等级
     */
    public  String getUserType(String username){
        return userMapper.check(username);
    }

    /*
        登录验证
     */
    public String login(User user){
        String result = userMapper.check(user.getUsername());
        if(result == null){
            return "noUser";
        }
        User user_in = userMapper.selectByUsername(user.getUsername());
        if(user_in.getPassword().equals(user.getPassword())){
            return user_in.getType();
        }else{
            return "errorPass";
        }

    }

    public int addUser(User user) throws IOException {
        //用户名作为逻辑主键，插入数据库前先检查用户名是否重复
        String username = userMapper.check(user.getUsername());
        System.out.println(username);
        if(username==null) {
            UserImage userImage = new UserImage();
            userImage.setUserid(user.getUsername());
            byte[] image;
            File file = new File(pathData.getCoursePath()+File.separator+"userDefaultImage.png");
            FileInputStream fis = new FileInputStream(file);
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] b = new byte[1024];
            int n;
            while ((n = fis.read(b)) != -1)
            {
                bos.write(b, 0, n);
            }
            fis.close();
            bos.close();
            image = bos.toByteArray();
            userImage.setUserimage(image);
            userimageService.insert(userImage);
            return userMapper.insert(user);
        }else{
            return 0;
        }
    }
    /*
        用户表的记录总数
     */
    public int countUser(){
        return userMapper.selectCount();
    }

    /*
        分页查询
     */
    public PageBean<User> showUserListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<User> pageBean = new PageBean<User>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=5;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = userMapper.selectCount();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<User> lists = userMapper.selectByPage(map);
        pageBean.setLists(lists);

        return pageBean;
    }

    /*
        用户编辑
        user为编辑后的用户信息
        username为编辑者的用户名
     */
    public int updateByUsername(User user,String username,String editedUsername){


        if("admin".equals(userMapper.check(username))){
            //管理员有权更新用户的所有信息
            return userMapper.updateByUsername(user);
        }else{
            //用户只能更新除密码、类型、积分以外的信息
            return userMapper.updateOthersByUsername(user);
        }

    }

    /*
        查看积分与排名
     */
    public Map checkIntegral(String username){
        Map<String,Integer> map= new HashMap<String,Integer>();
        map.put("integral",userMapper.selectByUsername(username).getCore());
        map.put("level",userMapper.selectIntegralRank(username));
        return map;
    }

    /*
        修改密码
     */
    public int updatePassByUsername(String username,User user){

        //获取原密码
        String prevPass = userMapper.selectByUsername(username).getPassword();
        //加入用户名
        user.setUsername(username);
        if(user.getPassword2().equals(prevPass)){
            //原密码确认，允许更新密码！
            return userMapper.updatePassByUsername(user);
        }else{
            //返回错误参数2，提示原密码输入错误！
            return 2;
        }
    }

    /*
        找回密码
     */
    public Map findPass(User user){
        Map<String,String> map= new HashMap<String,String>();
        if(userMapper.check(user.getUsername())==null){
            //无此用户名
            map.put("result","无此用户名");
        }else{
            if(user.getEmail().equals(userMapper.selectByUsername(user.getUsername()).getEmail())){
                //邮箱匹配成功，返回用户密码
                String password = userMapper.selectByUsername(user.getUsername()).getPassword();
                try{
                    //邮件主题
                    String emailTitle = "【退役士兵网站】找回密码";
                    //邮件内容
                    String emailContent = "您正在【退役士兵网站】进行密码找回，您的密码为：" + password;
                    //发送邮件
                    SendmailUtil.sendEmail(user.getEmail(), emailTitle, emailContent);

                }catch(Exception e){
                    //

                }

                map.put("password","您的密码已发送到邮箱，请注意查收");
                map.put("result","success");


            }else{
                //邮箱匹配失败
                map.put("result","邮箱输入错误");
            }
        }
        return map;

    }
    
    /*
        返回兴趣标签
     */
    public List<Tag> getTags(){
        return tagMapper.selectAllTags();
    }

    /*
        增加标签的引用记录
     */
    public int addTagsCitedNum(String tagname){
        return tagMapper.updateCitedNumByPrimaryKey(tagMapper.selectTagPK(tagname));
    }

    /*
        减少标签的引用记录
     */
    public int decreaseTagsCitedNum(String tagname){
        return tagMapper.decreaseCitedNumByPrimaryKey(tagMapper.selectTagPK(tagname));
    }


    /*
        查看我的标签
     */
    public List<UserTags> showMyTags(String username){
        return userTagsMapper.selectMyTags(username);
    }

    /*
        设置个人兴趣标签
    */
    public int setMyInterest(String username,int[] tags){

        for(int i=0;i<tags.length;i++){
            UserTags userTags = new UserTags();
            //判断有无重复提交
            HashMap<String,Object> map = new HashMap<String,Object>();
            map.put("userid",username);
            map.put("tagid",tags[i]);

            if(userTagsMapper.selectMyExistedTags(map)==null){
                userTags.setUserid(username);
                userTags.setTagid(tags[i]);
                userTags.setTagcontent(tagMapper.selectByPrimaryKey(tags[i]).getTag());
                userTagsMapper.insert(userTags);
            }else{
                return 0;
            }

        }

        return 1;

    }

    /*
     * 更改用户信息
     * */
    public int updateUser(User user){
        return userMapper.updateByPrimaryKey(user);
    }


    /*
        删除我的标签
     */
    public int deleteMyTags(int id){
        return userTagsMapper.deleteByPrimaryKey(id);
    }


    public User selectByUsername(String username){
        return userMapper.selectByUsername(username);
    }

    public int deleteByUsername(String username){
        return userMapper.deleteByUsername(username);
    }


}
