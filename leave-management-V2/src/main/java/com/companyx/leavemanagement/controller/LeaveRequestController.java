package com.companyx.leavemanagement.controller;

import com.companyx.leavemanagement.entity.LeaveRequest;
import com.companyx.leavemanagement.entity.LeaveStatus; // Thêm dòng này
import com.companyx.leavemanagement.repository.LeaveRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LeaveRequestController {

    @Autowired
    private LeaveRequestRepository leaveRequestRepository;

    @GetMapping("/leave/create")
    public String showCreateLeaveForm(Model model) {
        model.addAttribute("leaveRequest", new LeaveRequest());
        return "leave-form";
    }

    @PostMapping("/leave/create")
    public String createLeaveRequest(LeaveRequest leaveRequest, Authentication authentication) {
        // Gán trạng thái mặc định (Inprogress)
        leaveRequest.setStatus(new LeaveStatus(1, "Inprogress"));
        leaveRequestRepository.save(leaveRequest);
        return "redirect:/leave/list";
    }

    @GetMapping("/leave/list")
    public String listLeaveRequests(Model model, Authentication authentication) {
        model.addAttribute("leaveRequests", leaveRequestRepository.findAll());
        return "leave-list";
    }

    @GetMapping("/leave/review/{id}")
    public String showReviewForm(@PathVariable int id, Model model) {
        LeaveRequest request = leaveRequestRepository.findById(id).orElseThrow();
        model.addAttribute("leaveRequest", request);
        return "leave-review";
    }

    @PostMapping("/leave/review/{id}")
    public String reviewLeaveRequest(@PathVariable int id, @RequestParam String action, @RequestParam String processReason) {
        LeaveRequest request = leaveRequestRepository.findById(id).orElseThrow();
        if ("approve".equals(action)) {
            request.setStatus(new LeaveStatus(2, "Approved"));
        } else {
            request.setStatus(new LeaveStatus(3, "Rejected"));
        }
        request.setProcessReason(processReason);
        leaveRequestRepository.save(request);
        return "redirect:/leave/list";
    }
}