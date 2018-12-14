package com.CourseManage.service;

import com.CourseManage.dao.CourseTestMapper;
import com.CourseManage.dao.Test_scoreMapper;
import com.CourseManage.pojo.CourseTest;
import com.CourseManage.pojo.Test_score;
import com.Utils.Pagination.PageBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class CourseTestService {
    @Resource
    private CourseTestMapper courseTestMapper;
    @Resource
    private Test_scoreMapper test_scoreMapper;
    public int insertTest(int courseid,String testname,int price,String questionA,String questionB,String questionC,String op,int flag){
        CourseTest courseTest= new CourseTest();
        courseTest.setCourseId(courseid);
        courseTest.setTestName(testname);
        courseTest.setPice(price);
        courseTest.setQuestiona(questionA);
        courseTest.setQuestionb(questionB);
        courseTest.setQuestionc(questionC);
        courseTest.setOp(op);
        courseTest.setFlag(flag);
        return courseTestMapper.insert(courseTest);
    }
    /*
用户表的记录总数
*/
    public int countTest(int courseid){
        return courseTestMapper.selectCount(courseid);
    }
    /*
    分页查询
 */
    public PageBean<CourseTest> showCourseTestListByPage(int currentPage,int courseid){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<CourseTest> pageBean = new PageBean<CourseTest>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = courseTestMapper.selectCount(courseid);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid",courseid);
        //封装每页显示的数据
        List<CourseTest> lists = courseTestMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }
    public CourseTest select(int courseid,String testname){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("courseid",courseid);
        map.put("testname",testname);
        return courseTestMapper.selectByTestname(map);
    }
    public int deteleTest(int testID){
        return courseTestMapper.deleteByPrimaryKey(testID);
    }
    public int insertScore(int courseid,String studentname,int score){
        Test_score test_score = new Test_score();
        test_score.setCourseId(courseid);
        test_score.setStudentId(studentname);
        test_score.setScore(score);
        return test_scoreMapper.insert(test_score);
    }
    public int countScorce(int courseid){
        return test_scoreMapper.selectCount(courseid);
    }
    /*
    分页查询
 */
    public PageBean<Test_score> showScorceListByPage(int currentPage,int courseid){
        HashMap<String,Object> map = new HashMap<String,Object>();
        PageBean<Test_score> pageBean = new PageBean<Test_score>();

        //封装当前页数
        pageBean.setCurrPage(currentPage);

        //每页显示的数据
        int pageSize=10;
        pageBean.setPageSize(pageSize);

        //封装总记录数
        int totalCount = test_scoreMapper.selectCount(courseid);
        pageBean.setTotalCount(totalCount);

        //封装总页数
        double tc = totalCount;
        Double num =Math.ceil(tc/pageSize);//向上取整
        pageBean.setTotalPage(num.intValue());

        map.put("start",(currentPage-1)*pageSize);
        map.put("size", pageBean.getPageSize());
        map.put("courseid",courseid);
        //封装每页显示的数据
        List<Test_score> lists = test_scoreMapper.selectByPage(map);
        pageBean.setLists(lists);
        return pageBean;
    }
    public Test_score selectScore(int courseid,String studentid){
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("courseid",courseid);
        map.put("studentid",studentid);
        return test_scoreMapper.selectByStudentid(map);
    }
}
