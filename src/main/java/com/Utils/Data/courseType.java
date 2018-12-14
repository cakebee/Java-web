package com.Utils.Data;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("courseType")
public class courseType {

   // private static UserService userService = new UserService();
    private static List<String> types = new ArrayList<String>();

    static{
        //由数据库标签表获取全部标签

       /* List<Tag> list = userService.getTags();
        for(int i=0;i<list.size();i++){
            types.add(list.get(i).getTag());
        }*/

        types.add("Web开发");
        types.add("Android开发");
        types.add("操作系统");
    }

    public List<String> getTypes() {

        return types;

    }

    public void setTypes(List<String> types) {
        this.types = types;
    }

}
