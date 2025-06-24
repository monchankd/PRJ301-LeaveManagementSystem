package com.companyx.leavemanagement.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.EntityManager;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.PersistenceContext;

import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;

@Entity
@Table(name = "leave_requests")
public class LeaveRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id")
    private Integer requestId;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "reason")
    private String reason;

    @Column(name = "status")
    private String status;

    @Column(name = "created_by")
    private Integer createdBy; // user_id của người tạo

    @Column(name = "processed_by")
    private Integer processedBy; // user_id của người duyệt (null nếu Pending)

    private String createdByFullname; // Thêm thuộc tính tạm thời
    private String processedByFullname; // Thêm thuộc tính tạm thời
    // Getters và Setters

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Integer createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getProcessedBy() {
        return processedBy;
    }

    public void setProcessedBy(Integer processedBy) {
        this.processedBy = processedBy;
    }

    public String getCreatedByFullname() {
        return createdByFullname;
    }

    public void setCreatedByFullname(String createdByFullname) {
        this.createdByFullname = createdByFullname;
    }

    public String getProcessedByFullname() {
        return processedByFullname;
    }

    public void setProcessedByFullname(String processedByFullname) {
        this.processedByFullname = processedByFullname;
    }
    @PersistenceContext
    private transient EntityManager entityManager;

    @Autowired
    private transient UserRepository userRepository; // Inject repository (note: use @Transactional if needed)
}
