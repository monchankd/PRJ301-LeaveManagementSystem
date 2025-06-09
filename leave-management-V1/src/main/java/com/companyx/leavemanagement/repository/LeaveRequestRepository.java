package com.companyx.leavemanagement.repository;
import com.companyx.leavemanagement.entity.LeaveRequest;
import com.companyx.leavemanagement.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface LeaveRequestRepository extends JpaRepository<LeaveRequest, Long> {
    List<LeaveRequest> findByCreatedBy(User user);
    List<LeaveRequest> findByCreatedByOrCreatedByManager(User user, User manager);
    List<LeaveRequest> findByCreatedByAndFromDateLessThanEqualAndToDateGreaterThanEqual(User user, LocalDate end, LocalDate start);
}