package org.controller;

import com.google.gson.Gson;
import net.sf.json.JSONObject;
import org.entity.User;
import org.dao.UserDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.util.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liao on 17-2-9.
 */


@Controller
@RequestMapping("/user")
public class UserController {
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    UserDao userDao=new UserDao();
    @RequestMapping("/index")
    public ModelAndView testFreeMarker(HttpServletRequest request){

        ModelAndView mv=new ModelAndView("index");
        List<User> userList=userDao.list();
        //JSONObject jsonObject=new JSONObject();
        mv.addObject("userList",userList);
        return mv;
    }

    @RequestMapping("/list")
    public String list(HttpServletResponse response)throws Exception{
        List<User> userList=userDao.list();
        //ModelAndView mv=new ModelAndView("index");
        Map<Object, Object> info = new HashMap<Object, Object>();
        for (int i = 0; i < userList.size(); i++) {
            userList.get(i).setCreateTimeStr(format.format(userList.get(i).getCreateTime()));
            userList.get(i).setLastLoginStr(format.format(userList.get(i).getLastLogin()));
            if (userList.get(i).getState().equals("1")){
                userList.get(i).setStateStr("封存");
            }else {
                userList.get(i).setStateStr("解封");
            }
        }

        info.put("data", userList);
        String json = new Gson().toJson(info);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();

        out.write(json);
        return null;
    }

    @RequestMapping("/delete")
    public String delete(@RequestParam(value = "id")Integer id, HttpServletResponse response)throws Exception{
        userDao.delete(id);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

    @RequestMapping("/add")
    public ModelAndView add(){
        ModelAndView mv=new ModelAndView("add");
        return mv;
    }

    @RequestMapping("/addData")
    public String addData(@RequestParam(value = "id")String number,
                          @RequestParam(value = "type")String type,
                          @RequestParam(value = "state")String state,
                          @RequestParam(value = "userName")String userName,
                          @RequestParam(value = "start")String start,
                          @RequestParam(value = "last")String last,
                          HttpServletResponse response)throws Exception{

        User user=new User();
        user.setTypeName(type);
        user.setNumber(number);
        user.setUserName(userName);
        user.setState(state);
        Date date1;
        Date date2;

        date1=format.parse(start);
        date2=format.parse(last);
        user.setCreateTime(date1);
        user.setLastLogin(date2);
        userDao.add(user);

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

    @RequestMapping("/update/{id}")
    public ModelAndView update(@PathVariable("id") String id){
        ModelAndView mv=new ModelAndView("update");
        User user=userDao.findById(id);
        mv.addObject("user",user);
        return mv;
    }

    @RequestMapping("/updateData")
    public String updateData(@RequestParam(value = "id")String number,
                          @RequestParam(value = "type")String type,
                          @RequestParam(value = "state")String state,
                          @RequestParam(value = "userName")String userName,
                          @RequestParam(value = "start")String start,
                          @RequestParam(value = "last")String last,
                          HttpServletResponse response)throws Exception{

        User user=new User();
        user.setTypeName(type);
        user.setNumber(number);
        user.setUserName(userName);
        user.setState(state);
        Date date1;
        Date date2;
        date1=format.parse(start);
        date2=format.parse(last);
        user.setCreateTime(date1);
        user.setLastLogin(date2);
        userDao.update(user);

        JSONObject jsonObject=new JSONObject();
        jsonObject.put("success",true);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        out.print(jsonObject);
        return null;
    }

    @RequestMapping("/search")
    public void search(@RequestParam(value = "id")String number,
                       @RequestParam(value = "type")String typeName,
                       @RequestParam(value = "state")String state,
                       @RequestParam(value = "userName")String userName,
                       @RequestParam(value = "start")String start,
                       @RequestParam(value = "last")String last,
                       HttpServletResponse response)throws Exception{
        User user=new User();
        user.setNumber(number);
        user.setUserName(userName);
        user.setState(state);
        Date date1=format.parse(start);
        Date date2=format.parse(last);
        user.setCreateTime(date1);
        user.setLastLogin(date2);
        user.setTypeName(typeName);
        List<User> userList=userDao.search(user);

        for (int i = 0; i < userList.size(); i++) {
            userList.get(i).setCreateTimeStr(format.format(userList.get(i).getCreateTime()));
            userList.get(i).setLastLoginStr(format.format(userList.get(i).getLastLogin()));
            if (userList.get(i).getState().equals("1")){
                userList.get(i).setStateStr("封存");
            }else {
                userList.get(i).setStateStr("解封");
            }
        }
        JSONObject result=new JSONObject();
        result.put("userList", userList);
        ResponseUtil.write(response, result);
    }

}
