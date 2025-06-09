package com.companyx.leavemanagement.entity;
import lombok.Data;
import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity
@Table(name = "leave_requests")
public class LeaveRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private LocalDate fromDate;
    private LocalDate toDate;
    private String reason;
    @Enumerated(EnumType.STRING)
    private LeaveStatus status;
    @ManyToOne
    @JoinColumn(name = "created_by")
    private User createdBy;
    @ManyToOne
    @JoinColumn(name = "processed_by")
    private User processedBy;
}