package org.dao.imp;

import org.dao.UserDao;
import org.model.User;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.List;

public class UserDaoImp extends HibernateDaoSupport implements UserDao {
    @Override
    public List<User> findAllUser() {
        List<User> list = getHibernateTemplate().find("from User");
        return list;
    }

    @Override
    public User findUserById(int userId) {
        List<User> list = getHibernateTemplate().find("from User where userId = ?", userId);
        return (User)list.get(0);
    }

    @Override
    public User login(String username, String password) {
        String temp[] = {username, password};
        List<User> list = getHibernateTemplate().find("from User where userName = ? and userPassword = ?", temp);
        return (User)list.get(0);
    }
}
