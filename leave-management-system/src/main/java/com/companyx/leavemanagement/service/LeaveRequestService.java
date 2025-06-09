package com.companyx.leavemanagement.service;
import com.companyx.leavemanagement.entity.LeaveRequest;
import com.companyx.leavemanagement.entity.LeaveStatus;
import com.companyx.leavemanagement.entity.User;
import com.companyx.leavemanagement.repository.LeaveRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LeaveRequestService {
    @Autowired
    private LeaveRequestRepository leaveRequestRepository;
    @Autowired
    private UserService userService;

    public void createLeaveRequest(LeaveRequest leaveRequest) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.findByUsername(username);
        leaveRequest.setCreatedBy(user);
        leaveRequest.setStatus(LeaveStatus.INPROGRESS);
        leaveRequestRepository.save(leaveRequest);
    }

    public List<LeaveRequest> getLeaveRequestsForUser(String username) {
        User user = userService.findByUsername(username);
        return leaveRequestRepository.findByCreatedByOrCreatedByManager(user, user);
    }

    public void approveLeaveRequest(Long id) {
        LeaveRequest request = leaveRequestRepository.findById(id).orElseThrow();
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.findByUsername(username);
        request.setProcessedBy(user);
        request.setStatus(LeaveStatus.APPROVED);
        leaveRequestRepository.save(request);
    }

    public void rejectLeaveRequest(Long id, String reason) {
        LeaveRequest request = leaveRequestRepository.findById(id).orElseThrow();
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.findByUsername(username);
        request.setProcessedBy(user);
        request.setStatus(LeaveStatus.REJECTED);
        leaveRequestRepository.save(request);
    }

    public Map<User, Map<LocalDate, String>> getAgenda(LocalDate start, LocalDate end, List<User> users) {
        Map<User, Map<LocalDate, String>> agenda = new HashMap<>();
        for (User user : users) {
            Map<LocalDate, String> userAgenda = new HashMap<>();
            for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
                boolean onLeave = leaveRequestRepository.findByCreatedByAndFromDateLessThanEqualAndToDateGreaterThanEqual(user, date, date)
                    .stream()
                    .anyMatch(lr -> lr.getStatus() == LeaveStatus.APPROVED);
                userAgenda.put(date, onLeave ? "LEAVE" : "WORKING");
            }
            agenda.put(user, userAgenda);
        }
        return agenda;
    }
}