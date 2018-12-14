package com.CourseManage.service;

import com.CourseManage.dao.CourseMapper;
import com.CourseManage.dao.CourseResourcesMapper;
import com.CourseManage.dao.CourseStuMapper;
import com.CourseManage.pojo.*;
import com.UserManage.dao.UserTagsMapper;
import com.UserManage.pojo.UserTags;
import com.UserManage.service.UserService;
import com.Utils.Data.PathData;
import com.Utils.Pagination.PageBean;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("CourseManageService")
public class CourseManageService {
    @Resource
    private CourseMapper courseMapper;
    @Resource
    private CourseResourcesMapper courseResourcesMapper;
    @Resource
    private PathData pathData;
    @Resource
    private UserService userService;
    @Resource
    private UserTagsMapper userTagsMapper;
    @Resource
    private CourseStuMapper courseStuMapper;


    public int releaseCourse(Course course){
        //插入数据库表
        courseMapper.insert(course);
        int i = course.getId();

        //更新对应的记录引用标签
        userService.addTagsCitedNum(course.getCoursetype());

        if(i!=0){
            //在指定位置创建该课程的目
            String dirpath = pathData.getCoursePath()+File.separator+course.getTeacher()+course.getCoursename();
            File dir = new File(dirpath);
            if (dir.mkdirs()) {
                System.out.println("创建目录" + dirpath + "成功！");
            } else {
                System.out.println("创建目录" + dirpath + "失败！");
            }

        }

        return i;
    }


    /*
        分页所有查询课程
     */
    public PageBean<Course> showCourseListByPage(int currentPage){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseMapper.selectCountAll();
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        //封装每页显示的数据
        List<Course> lists = courseMapper.selectAllByPage(map);
        pageBean.setLists(lists);


        return pageBean;
    }

    /*
        分页查询我的课程
     */
    public PageBean<Course> showMyCourseListByPage(int currentPage,String teacher){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseMapper.selectCount(teacher);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("teacher", teacher);
        //封装每页显示的数据
        List<Course> lists = courseMapper.selectByPage(map);
        pageBean.setLists(lists);


        return pageBean;
    }

    /*
        展示课程详细信息
     */
    public Course showCourse(int courseID){
        return courseMapper.selectByPrimaryKey(courseID);
    }

    /*
        编辑课程
     */
    public int editCourse(Course course){
        return courseMapper.updateCourse(course);
    }

    /*
        删除课程
     */
    public int deleteCourse(int courseID)throws Exception{
        //TODO：删除相关表中的表项
        //删除目录
        String dirpath = pathData.getCoursePath()+File.separator+courseMapper.selectByPrimaryKey(courseID).getTeacher()+
                courseMapper.selectByPrimaryKey(courseID).getCoursename();
        File dir = new File(dirpath);
        FileUtils.deleteDirectory(dir);
        //引用标签减一
        userService.decreaseTagsCitedNum(courseMapper.selectByPrimaryKey(courseID).getCoursetype());

        return courseMapper.deleteByPrimaryKey(courseID);
    }

    /*
        分页查询我的课程资源
     */
    public PageBean<CourseResources> showCourseResourceListByPage(int currentPage,int courseID){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseResources> pageBean = new PageBean<CourseResources>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseResourcesMapper.selectCourseResourceCount(courseID);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid",courseID);
        //封装每页显示的数据
        List<CourseResources> lists = courseResourcesMapper.selectCourseResourceByPage(map);
        pageBean.setLists(lists);

        return pageBean;
    }

    /*
        分页查询已通过审核课程资源
     */
    public PageBean<CourseResources> showPassCourseResourceListByPage(int currentPage,int courseID){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseResources> pageBean = new PageBean<CourseResources>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseResourcesMapper.selectPassCourseResources(courseID);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid",courseID);

        //封装每页显示的数据
        List<CourseResources> lists = courseResourcesMapper.selectPassCourseResourceByPage(map);
        pageBean.setLists(lists);

        return pageBean;
    }

    /*
        上传资源
     */
    public int uploadCourseFileResource(int courseID,String type,String name,MultipartFile file) throws Exception{

        String path = pathData.getCoursePath()+File.separator+courseMapper.selectByPrimaryKey(courseID).getTeacher()+
                courseMapper.selectByPrimaryKey(courseID).getCoursename();

        CourseResources courseResources = new CourseResources();
        courseResources.setCourseid(courseID);
        courseResources.setName(name);
        courseResources.setType(type);
        courseResources.setFilename(file.getOriginalFilename());

        int i = courseResourcesMapper.insert(courseResources);

        if(i==1){

            File filepath = new File(path,file.getOriginalFilename());
            //判断路径是否存在，如果不存在就创建一个
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs();
            }
            file.transferTo(filepath);

        }

        return courseResources.getId();
    }

    /*
        下载资源处理
     */
    public void downloadCourseResource(int crid,String username){

    }

    /*
        获取资源数据
     */
    public CourseResources getCourseResource(int crid){
        return courseResourcesMapper.selectByPrimaryKey(crid);
    }


    /*
        分页查询：关键字搜索课程
        type=1：查询课程名称关键字
        type=2：查询教师课程
        type=3: 查询课程类型关键字
        type=4: 查询所有审核通过过程
     */

    public PageBean<Course> showKeyCourseListsByPage(int currentPage,int type,String keywords){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = 0;
        if(type==1){
            totalCount = courseMapper.selectKeyCourseCount("%"+keywords+"%");
        }else if(type==2){
            totalCount = courseMapper.selectKeyTeacherCount(keywords);
        }else if(type==3){
            totalCount = courseMapper.selectKeyTypeCount("%"+keywords+"%");
        }else if(type==4){
            totalCount = courseMapper.selectPassCourseCount();
        }

        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        if(type==1){
            map.put("keywords","%"+keywords+"%");
        }else if(type==2){
            map.put("keywords",keywords);
        }else if(type==3){
            map.put("keywords","%"+keywords+"%");
        }

        //封装每页显示的数据
        List<Course> lists;
        if(type==1){
            lists = courseMapper.selectKeyCourseByPage(map);
        }else if(type==2){
            lists = courseMapper.selectKeyTeacherByPage(map);
        }else if(type==3){
            lists = courseMapper.selectTypeCourseByPage(map);
        }else{
            lists = courseMapper.selectPassCourseByPage(map);
        }

        pageBean.setLists(lists);

        return pageBean;
    }

    /*
        分页查询：用户感兴趣课程
    */

    public PageBean<Course> showMyInterestCourseListByPage(int currentPage,String username){

        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //获取用户兴趣标签
        List<String> list = new ArrayList<String>();
        List<UserTags> tagsList = userTagsMapper.selectMyTags(username);

        if(tagsList.size()!=0){
            for(int i=0;i<tagsList.size();i++)
                list.add(tagsList.get(i).getTagcontent());


            //封装总记录数
            int totalCount = courseMapper.selectMyInterestTypeCourseCount(list);
            pageBean.setTotalCount(totalCount);

            //封装总页数
            double tc = totalCount;
            Double num =Math.ceil(tc/pageSize);//向上取整
            pageBean.setTotalPage(num.intValue());

            //封装每页显示的数据
            List<Course> lists;
            map.put("start",(currentPage-1)*pageSize);
            map.put("size", pageBean.getPageSize());
            map.put("tags",list);

            lists = courseMapper.selectMyInterestTypeCourseByPage(map);
            pageBean.setLists(lists);
        }


        return pageBean;
    }

    /*
        热门课程
     */
    public PageBean<Course> showHotCourse(){

        PageBean<Course> pageBean = new PageBean<Course>();

        List<Integer> IDlist = courseStuMapper.selectHotCourse();
        if(IDlist.size()==0){
            return pageBean;
        }
        List<Course> list = courseMapper.selectHotCourses(IDlist);
        pageBean.setLists(list);

        return pageBean;
    }

    /*
        参与学习
     */
    public int participateLearning(int courseid,String username){

        CourseStu courseStu = new CourseStu();
        courseStu.setCourseid(courseid);
        courseStu.setUserid(username);

        if(courseStuMapper.checkMyParticipateCourse(courseStu)==null){
            return courseStuMapper.insert(courseStu);
        }else{
            return 0;
        }
    }

    /*
        检查是否参与课程
     */
    public boolean checkMyParticipate(int courseid,String username){

        CourseStu courseStu = new CourseStu();
        courseStu.setCourseid(courseid);
        courseStu.setUserid(username);

        if(courseStuMapper.checkMyParticipateCourse(courseStu)==null){
            //未参与该课程
            return false;
        }else{
            //参与该课程
            return true;
        }

    }

    /*
        分页：查看我学习的课程
     */
    public PageBean<Course> showMyParticipateCourse(int currentPage,String username){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Course> pageBean = new PageBean<Course>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseStuMapper.selectMyParticipateCourseCount(username);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        //封装每页显示的数据
        List<Course> lists = new ArrayList<Course>();
        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("username",username);

        //获取用户与课程映射对象数组
        List<CourseStu> courseStuList = courseStuMapper.selectMyParticipateCourseByPage(map);

        //通过返回的我参与的课程ID循化获得课程对象
        for(int i=0;i<courseStuList.size();i++)
            lists.add(courseMapper.selectByPrimaryKey(courseStuList.get(i).getCourseid()));

        pageBean.setLists(lists);

        return pageBean;
    }

    /*
        退出学习
     */
    public int abortMyCourse(String username,int courseID){
        //TODO:删除关联表项
        HashMap<String,Object> map = new HashMap<String, Object>();
        map.put("username",username);
        map.put("courseid",courseID);
        return courseStuMapper.deleteMyParticipateCourse(map);
    }

    /*
        查询已通过审核课程资源
     */
    public List<CourseResources> showPassCourseResourceList(int courseID){
        return courseResourcesMapper.selectPassCourseResource(courseID);
    }

    /*
        分页查询某课程学生成绩排名
     */
    public PageBean<stuScoreRank> showStuScoreRank(int currentPage,int courseid) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        PageBean<stuScoreRank> pageBean = new PageBean<stuScoreRank>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize = 10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseStuMapper.selectStuScoreRankCount(courseid);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num = Math.ceil(tc / pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        //封装每页显示的数据
        List<Course> lists = new ArrayList<Course>();
        map.put("start", (currentPage - 1) * pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid", courseid);

        //获取用户与课程映射对象数组
        List<stuScoreRank> stuScoreRankLists = courseStuMapper.selectStuScoreRank(map);

        pageBean.setLists(stuScoreRankLists);

        return pageBean;

    }

    /*
        分页查询我的成绩
     */
    public PageBean<CourseScore> showMyAllCourseScore(String username,int currentPage){

        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseScore> pageBean = new PageBean<CourseScore>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseStuMapper.selectMyParticipateCourseCount(username);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        //封装每页显示的数据
        List<CourseScore> lists = new ArrayList<CourseScore>();

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("username",username);

        //获取用户与课程映射对象数组
        List<CourseStu> courseStuList = courseStuMapper.selectMyParticipateCourseByPage(map);

        //通过返回的我参与的课程ID循化获得课程对象,并对CourseScore对象赋值
        for(int i=0;i<courseStuList.size();i++){
            CourseScore courseScore = new CourseScore();
            courseScore.setCoursename(courseMapper.selectByPrimaryKey(courseStuList.get(i).getCourseid()).getCoursename());
            courseScore.setCoursetype(courseMapper.selectByPrimaryKey(courseStuList.get(i).getCourseid()).getCoursetype());
            courseScore.setTeacher(courseMapper.selectByPrimaryKey(courseStuList.get(i).getCourseid()).getTeacher());
            courseScore.setScore(courseStuList.get(i).getScore());
            lists.add(courseScore);
        }

        pageBean.setLists(lists);

        return pageBean;
    }


    /*
        更新学生某课程的分数
    */
    public int updataStuCourseScore(String username,int courseID,int score){

        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("username",username);
        map.put("courseid",courseID);

        int preScore = courseStuMapper.selectMyCourseScore(map);
        int nowScore = preScore + score;

        map.put("score",nowScore);

        return courseStuMapper.updateScoreByUIDCourseID(map);

    }

    /*
        删除课程资源
     */
    public int deleteCourseResource(int crID){
        return courseResourcesMapper.deleteByPrimaryKey(crID);
    }

}
