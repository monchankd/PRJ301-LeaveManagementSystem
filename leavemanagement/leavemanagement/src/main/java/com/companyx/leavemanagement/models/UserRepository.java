/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.companyx.leavemanagement.models;

/**
 *
 * @author ASUS
 */
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Integer> {
    @Query("SELECT u FROM User u WHERE u.username = :username AND u.passwordHash = :passwordHash")
    User findByUsernameAndPasswordHash(String username, String passwordHash);
    boolean existsByUsername(String username); // Kiểm tra username đã tồn tại
    List<User> findByManagerId(Integer managerId); // Lấy cấp dưới
}
