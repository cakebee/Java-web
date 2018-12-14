package com.CourseManage.service;

import com.CourseManage.dao.CourseWorkMapper;
import com.CourseManage.pojo.CourseWork;
import com.Utils.Data.PathData;
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
import java.util.Date;
import java.util.List;

@Service
public class CourseWorkService {
    @Resource
    private CourseWorkMapper courseWorkMapper;
    @Resource
    private PathData pathData;
    @Resource
    private WorkScoreService workScoreService;

    /*
        描述：获取一个作业
     */
    public CourseWork getWork(int wordID){
        return courseWorkMapper.selectByPrimaryKey(wordID);
    }

    /*
        描述：老师新建一个作业
        参数：CourseWork courseWork    //作业对象
            MultipartFile file  //作业文件
        附：文件位置：workPath/课程ID/作业文件
     */
    public int addWork(CourseWork courseWork, MultipartFile file) throws Exception{
        String path = pathData.getWorkPath()+File.separator + courseWork.getCourseid();

        courseWork.setFilename(file.getOriginalFilename());
        courseWork.setPublishdate(new Date());

        int result = courseWorkMapper.insert(courseWork);

        if(result == 1){
            File filepath = new File(path, file.getOriginalFilename());
            if(!filepath.getParentFile().exists()){
                filepath.getParentFile().mkdirs();
            }
            file.transferTo(filepath);
        }else {
            return 1;
        }
        return 0;
    }

    /*
        描述：获取一个课程下的所有作业的列表
        参数：课程号
     */
    public List<CourseWork> getWorksList(int courseID){
        return courseWorkMapper.selectByCourseIDOrderChapterPart(courseID);
    }

    /*
        描述：老师删除一个作业，同时删除该作业下，所有学生已提交的作业,包括文件及文件夹
        参数：作业ID
     */
    public int delWork(int workID) throws IOException{
        int courseID = courseWorkMapper.selectByPrimaryKey(workID).getCourseid();
        String stuWorkpath = pathData.getWorkPath() + File.separator + courseID + File.separator + workID;
        /*String workpath = pathData.getWorkPath()+File.separator + courseWork.getCourseid();*/
        File stuWorkfile = new File(stuWorkpath);
        FileUtils.deleteDirectory(stuWorkfile);
        courseWorkMapper.deleteByPrimaryKey(workID);
        workScoreService.delAllStuWork(workID);
        return 0;
    }

    /*
        描述：删除存放作业的文件夹，文件夹名为课程ID
        参数：课程ID
     */
    public int delWorkDir(int courseID){
        return 0;
    }

    /*
        描述：下载作业
        参数：作业ID
     */
    public ResponseEntity<byte[]> downloadWork(int workID) throws IOException {
        CourseWork courseWork = courseWorkMapper.selectByPrimaryKey(workID);
        String path = pathData.getWorkPath()+File.separator + courseWork.getCourseid();
        String fileName = courseWork.getFilename();

        File file = new File(path, fileName);
        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", new String(fileName.getBytes("gb2312"), "iso8859-1"));

        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
    }

    public int getCourseID(int workID){
        return courseWorkMapper.selectByPrimaryKey(workID).getCourseid();
    }
}
