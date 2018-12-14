package com.CourseManage.service;

import com.CourseManage.dao.WorkScoreMapper;
import com.CourseManage.pojo.CourseWork;
import com.CourseManage.pojo.WorkScore;
import com.Utils.Data.PathData;
import com.Utils.Pagination.PageBean;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@Service
public class WorkScoreService {
    @Resource
    private WorkScoreMapper workScoreMapper;
    @Resource
    private PathData pathData;
    @Resource
    private CourseWorkService courseWorkService;
    @Resource
    private CourseManageService courseManageService;

    /*
        描述：学生提交一个作业
        附：默认分数为-1分，即未评分
     */
    public boolean submitStuWork(WorkScore workScore, MultipartFile file) throws IOException {
        int courseID = courseWorkService.getCourseID(workScore.getWorkid());
        String path = pathData.getWorkPath() + File.separator + courseID + File.separator + workScore.getWorkid();
        String filename = workScore.getUserid() + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        HashMap<String,Object> map = new HashMap<String, Object>();
        int result;

        workScore.setFilename(filename);
        workScore.setIsreaded((byte)0);
        workScore.setScore(-1);

/*        map.put("workID", workScore.getWorkid());
        map.put("userID", workScore.getUserid());
        map.put("score", workScore.getScore());
        map.put("filename", workScore.getFilename());
        map.put("isreaded", workScore.getIsreaded());*/

        //判断同一个作业同一个学生是否已经提交过
        if(!isSubmit(workScore.getWorkid(), workScore.getUserid())){
            result = workScoreMapper.insert(workScore);
            System.out.println("插入");
        }else {
            result = workScoreMapper.updateFileByWorkIDUserID(workScore);
            System.out.println("更新");
        }

        System.out.println(workScore.getUserid());

        //判断插入或者更新是否成功
        if(result == 1){
            File filepath = new File(path, filename);
            if(!filepath.getParentFile().exists()){
                filepath.getParentFile().mkdirs();
            }
            file.transferTo(filepath);
            return true;
        }else {
            return false;
        }
    }

    /*
        描述：（分页）查询一个作业下的所有学生提交的作业列表
        参数：int workID //作业号
             int currentPage    //当前页数
     */
    public PageBean<WorkScore> getStuWorks(int workID, int currentPage){
        int pageSize = 10;//每页显示10条数据
        int totalCount;
        double tc;
        PageBean<WorkScore> pageBean = new PageBean<WorkScore>();
        List<WorkScore> stuWorksList;
        Double num;
        HashMap<String,Object> map = new HashMap<String, Object>();
        totalCount = workScoreMapper.selectCountByWorkID(workID);

        tc = totalCount;
        num = Math.ceil(tc/pageSize);

        pageBean.setTotalCount(totalCount);
        pageBean.setTotalPage(num.intValue());
        pageBean.setCurrPage(currentPage);
        pageBean.setPageSize(pageSize);

        map.put("start", (currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("workID", workID);

        stuWorksList = workScoreMapper.selectByWorkID(map);
        pageBean.setLists(stuWorksList);

        return pageBean;
    }

    public boolean delStuWork(int workScoreID){
        WorkScore workScore = workScoreMapper.selectByPrimaryKey(workScoreID);
        int courseID = courseWorkService.getCourseID(workScore.getWorkid());
        String path = pathData.getWorkPath() + File.separator + courseID + File.separator + workScore.getWorkid();
        String filename = workScore.getFilename();

        File file = new File(path,filename);
        if(file.delete()){
            workScoreMapper.deleteByPrimaryKey(workScoreID);
            return true;
        }else {
            return false;
        }
    }

    /*
        描述：删除某个作业下的所有学生作业在数据库中的记录
     */
    public boolean delAllStuWork(int workID){
        workScoreMapper.deleteByWorkID(workID);
        return true;
    }

    /*
        描述：下载一个学生提交的作业
     */
    public ResponseEntity<byte[]> downloadStuWork(int workScoreID) throws IOException{
        WorkScore workScore = workScoreMapper.selectByPrimaryKey(workScoreID);
        int courseID = courseWorkService.getCourseID(workScore.getWorkid());
        String path = pathData.getWorkPath() + File.separator + courseID + File.separator + workScore.getWorkid();
        String filename = workScore.getFilename();
        File file = new File(path, filename);
        HttpHeaders headers = new HttpHeaders();

        workScore.setIsreaded((byte)1); //设置老师已读
        workScoreMapper.updateByPrimaryKey(workScore);//更新记录

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment",filename);

        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
    }

    /*
       描述：老师给学生提交的一份作业打分,只能打一次
       参数：作业号
    */
    public int setScore(int workScoreID, int score){
        WorkScore workScore = workScoreMapper.selectByPrimaryKey(workScoreID);
        CourseWork courseWork = courseWorkService.getWork(workScore.getWorkid());
        if(workScore.getScore() == -1){
            workScore.setScore(score);
            workScoreMapper.updateByPrimaryKey(workScore);
            System.out.println(workScore.getUserid() + courseWork.getCourseid() + score);
            courseManageService.updataStuCourseScore(workScore.getUserid(), courseWork.getCourseid(), score);

            return 0;
        }
        return -1;
    }

    public boolean isSubmit(int workID, String userID){
        HashMap<String,Object> map = new HashMap<String, Object>();

        map.put("workID", workID);
        map.put("userID", userID);

        if(workScoreMapper.selectByWorkIDUserID(map).size()==0){
            return false;
        }else {
            return true;
        }
    }

    public int getScore(int workID, String userID){
        HashMap<String,Object> map = new HashMap<String, Object>();

        map.put("workID", workID);
        map.put("userID", userID);
        List<WorkScore> list = workScoreMapper.selectByWorkIDUserID(map);
        if(list.size() == 1){
             return list.get(0).getScore();
        }
        return -1;
    }
}
