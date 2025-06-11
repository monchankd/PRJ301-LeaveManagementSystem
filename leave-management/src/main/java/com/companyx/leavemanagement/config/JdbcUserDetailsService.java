/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.companyx.leavemanagement.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class JdbcUserDetailsService implements UserDetailsService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        String userSql = "SELECT username, password, enabled FROM users WHERE username = ?";
        List<UserDetails> users = jdbcTemplate.query(userSql, new Object[]{username}, (rs, rowNum) -> {
            String password = rs.getString("password");
            boolean enabled = rs.getBoolean("enabled");
            return new User(username, password, enabled, true, true, true, getAuthorities(username));
        });

        if (users.isEmpty()) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        return users.get(0);
    }

    private List<SimpleGrantedAuthority> getAuthorities(String username) {
        String roleSql = "SELECT role FROM user_roles WHERE username = ?";
        return jdbcTemplate.query(roleSql, new Object[]{username}, (rs, rowNum) ->
            new SimpleGrantedAuthority(rs.getString("role"))
        );
    }
}