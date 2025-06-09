package com.companyx.leavemanagement.repository;


import com.companyx.leavemanagement.entity.LeaveRequest;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LeaveRequestRepository extends JpaRepository<LeaveRequest, Integer> {
}