package com.companyx.leavemanagement.entity;
@Entity
@Table(name = "LeaveStatus")
public class LeaveStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int statusId;
    private String statusName;

    // Getters and Setters
}