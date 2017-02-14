package org.dao;

import org.entity.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by liao on 17-2-9.
 */


public class UserDao {

    ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
    JdbcTemplate f = applicationContext.getBean("jdbcTemplate", JdbcTemplate.class);

    //查询所有数据
    public List<User> list(){
        String sql = "SELECT * FROM user";

        List<User> userList=f.query(sql,new BeanPropertyRowMapper(
                User.class));
        return userList;
    }
    //删除数据
    public void delete(int id){
        String sql="delete from user where number=?";
        f.update(sql,id);
    }

    //增加数据
    public void add(User user){
        String sql="insert into user values(?,?,?,?,?,?)";
        Timestamp timeStamp = new Timestamp(user.getCreateTime().getTime());
        Timestamp timeStamp1 = new Timestamp(user.getLastLogin().getTime());
        f.update(sql,user.getNumber(),user.getUserName(),user.getState()
        ,timeStamp,timeStamp1,user.getTypeName());
    }

/*    public List<UserType> listUserType(){
        String sql="select * from userType";
        List<UserType> userTypeList=f.query(sql,new BeanPropertyRowMapper(
                UserType.class));
        return userTypeList;
    }*/

    public User findById(String id){
        String sql="select * from user where number=?";
        Object[] args = new Object[] {id};
        Object user=f.queryForObject(sql,args,new BeanPropertyRowMapper(
                User.class));
        return (User)user;
    }

    public void update(User user){
        String sql="update user set userName=?,state=?,createTime=?,lastLogin=?,typeName=? where number=?";

        Timestamp timeStamp = new Timestamp(user.getCreateTime().getTime());
        Timestamp timeStamp1 = new Timestamp(user.getLastLogin().getTime());
        System.out.println("test:"+user.getTypeName());
        f.update(sql,user.getUserName(),user.getState(),timeStamp,timeStamp1,user.getTypeName(),user.getNumber());
    }

    public List<User> search(User user){
        Timestamp timeStamp = new Timestamp(user.getCreateTime().getTime());
        Timestamp timeStamp1 = new Timestamp(user.getLastLogin().getTime());
        String sql="select * from user where 1=1";
        List<Object> queryList=new ArrayList<Object>();
        sql += " and user.number like ? ";
        queryList.add("%" + user.getNumber() + "%");
        sql += " and user.userName like ? ";
        queryList.add("%" + user.getUserName() + "%");
        sql += " and user.state = ? ";
        queryList.add(user.getState());
        sql += " and user.createTime = ? ";
        queryList.add(timeStamp);
        sql += " and user.lastLogin = ? ";
        queryList.add(timeStamp1);
        return f.query(sql, queryList.toArray(),new BeanPropertyRowMapper(
                User.class));
    }
}
