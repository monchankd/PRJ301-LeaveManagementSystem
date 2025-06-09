package com.companyx.leavemanagement.controller;
import com.companyx.leavemanagement.entity.LeaveRequest;
import com.companyx.leavemanagement.service.LeaveRequestService;
import com.companyx.leavemanagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class LeaveRequestController {

    @Autowired
    private LeaveRequestService leaveRequestService;

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/leave/create")
    public String showCreateForm(Model model) {
        model.addAttribute("leaveRequest", new LeaveRequest());
        return "leave-create";
    }

    @PostMapping("/leave/create")
    public String createLeaveRequest(LeaveRequest leaveRequest) {
        leaveRequestService.createLeaveRequest(leaveRequest);
        return "redirect:/leave/list";
    }

    @GetMapping("/leave/list")
    public String listLeaveRequests(Model model) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        List<LeaveRequest> leaveRequests = leaveRequestService.getLeaveRequestsForUser(username);
        model.addAttribute("leaveRequests", leaveRequests);
        return "leave-list";
    }

    @GetMapping("/leave/approve/{id}")
    public String approveLeaveRequest(@PathVariable Long id) {
        leaveRequestService.approveLeaveRequest(id);
        return "redirect:/leave/list";
    }

    @GetMapping("/leave/reject/{id}")
    public String rejectLeaveRequest(@PathVariable Long id, @RequestParam(required = false) String reason) {
        leaveRequestService.rejectLeaveRequest(id, reason);
        return "redirect:/leave/list";
    }

    @GetMapping("/agenda")
    public String showAgenda(@RequestParam String startDate, @RequestParam String endDate, Model model) {
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        List<User> departmentUsers = userService.getDepartmentUsers(1L); // Assuming department ID 1 for IT
        Map<User, Map<LocalDate, String>> agenda = leaveRequestService.getAgenda(start, end, departmentUsers);
        model.addAttribute("agenda", agenda);
        model.addAttribute("dates", getDateRange(start, end));
        return "agenda";
    }

    private List<LocalDate> getDateRange(LocalDate start, LocalDate end) {
        return start.datesUntil(end.plusDays(1)).collect(Collectors.toList());
    }
}