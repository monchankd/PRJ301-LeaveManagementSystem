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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface LeaveRequestRepository extends JpaRepository<LeaveRequest, Integer> {
    List<LeaveRequest> findByUser_UserId(Integer userId); // Tìm theo userId
    List<LeaveRequest> findByUser_UserIdIn(List<Integer> userIds);
    @Override
    List<LeaveRequest> findAll(); // Thêm để lấy tất cả yêu cầu

    // Pagination support
    Page<LeaveRequest> findByUser_UserId(Integer userId, Pageable pageable);
    Page<LeaveRequest> findAll(Pageable pageable);
    Page<LeaveRequest> findByUser_UserIdIn(List<Integer> userIds, Pageable pageable);
}
