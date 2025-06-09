package com.companyx.leavemanagement.entity;
import lombok.Data;
import javax.persistence.*;

@Data
@Entity
@Table(name = "features")
public class Feature {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
}