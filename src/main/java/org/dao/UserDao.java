package org.dao;

import org.model.User;

import java.util.List;

public interface UserDao {
    List<User> findAllUser();
    User findUserById(int userId);
    User login(String username, String password);
}
