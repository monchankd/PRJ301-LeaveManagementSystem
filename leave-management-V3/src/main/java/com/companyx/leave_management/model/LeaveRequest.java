package main.java.com.companyx.leave_management.model;

@Entity
public class LeaveRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private User creator;
    private LocalDate fromDate;
    private LocalDate toDate;
    private String reason;
    @Enumerated(EnumType.STRING)
    private Status status;
    @ManyToOne
    private User approvedBy;
    // Getters, setters
}