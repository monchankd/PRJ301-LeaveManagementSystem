package com.companyx.leavemanagement.repository;
import com.companyx.leavemanagement.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
}