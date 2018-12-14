package com.Utils.Data;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("registerData")
public class registerData {

    //private  static List<String> genders = new ArrayList<String>();
    private  static Map<String, String > genders = new HashMap<String, String >();
    private  static List<String> levels = new ArrayList<String>();
    static {
        //genders.add("man");
        //genders.add("women");
        genders.put("man","男");
        genders.put("woman","女");
        levels.add("teacher");
        levels.add("student");
    }

    public static Map<String, String > getGenders() {
        return genders;
    }

    public static List<String> getLevels() {
        return levels;
    }
}
