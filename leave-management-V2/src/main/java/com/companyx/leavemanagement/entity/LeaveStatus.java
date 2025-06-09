package com.companyx.leavemanagement.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "LeaveStatus")
public class LeaveStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int statusId;
    private String statusName;

    // Constructor mặc định
    public LeaveStatus() {}

    // Constructor với tham số
    public LeaveStatus(int statusId, String statusName) {
        this.statusId = statusId;
        this.statusName = statusName;
    }

    // Getters and Setters
    public int getStatusId() { return statusId; }
    public void setStatusId(int statusId) { this.statusId = statusId; }
    public String getStatusName() { return statusName; }
    public void setStatusName(String statusName) { this.statusName = statusName; }
}