package com.companyx.leavemanagement.entity;
@Entity
@Table(name = "Users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;
    private String username;
    private String password;
    private String fullName;

    @ManyToOne
    @JoinColumn(name = "DepartmentId")
    private Department department;

    @ManyToOne
    @JoinColumn(name = "ManagerId")
    private User manager;

    // Getters and Setters
}