package com.companyx.leavemanagement.service;
import com.companyx.leavemanagement.entity.User;
import com.companyx.leavemanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public List<User> getDepartmentUsers(Long departmentId) {
        return userRepository.findAll().stream()
            .filter(user -> user.getDepartment().getId().equals(departmentId))
            .toList();
    }
}