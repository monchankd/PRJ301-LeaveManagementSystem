package com.companyx.leavemanagement.entity;
import lombok.Data;
import javax.persistence.*;

@Data
@Entity
@Table(name = "departments")
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
}