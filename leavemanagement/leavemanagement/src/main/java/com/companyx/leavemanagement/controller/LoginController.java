/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.companyx.leavemanagement.controller;

/**
 *
 * @author ASUS
 */
import com.companyx.leavemanagement.models.LeaveRequest;
import com.companyx.leavemanagement.models.LeaveRequestRepository;
import com.companyx.leavemanagement.models.User;
import com.companyx.leavemanagement.models.UserRepository;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private LeaveRequestRepository leaveRequestRepository;

    @GetMapping("/")
    public String showIndexPage() {
        return "index"; // Trả về index.jsp trong WEB-INF/views/
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public ModelAndView login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = userRepository.findByUsernameAndPasswordHash(username, password); // Giả sử password là passwordHash
        if (user != null) {
            session.setAttribute("user", user);
            modelAndView.setViewName("redirect:/dashboard");
        } else {
            modelAndView.addObject("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            modelAndView.setViewName("login");
        }
        return modelAndView;
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        return "dashboard";
    }

    @GetMapping("/submitLeaveRequest")
    public String showLeaveRequestForm(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        return "leaveRequest";
    }

    @PostMapping("/submitLeaveRequest")
    public ModelAndView submitLeaveRequest(@RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("reason") String reason,
            HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.addObject("message", "User session is invalid. Please log in again.");
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }

        LeaveRequest leaveRequest = new LeaveRequest();
        leaveRequest.setUser(user);
        leaveRequest.setCreatedBy(user.getUserId()); // Đảm bảo gán giá trị ngay từ đầu

        try {
            leaveRequest.setStartDate(LocalDate.parse(startDate));
            leaveRequest.setEndDate(LocalDate.parse(endDate));
            if (leaveRequest.getEndDate().isBefore(leaveRequest.getStartDate())) {
                modelAndView.addObject("message", "End date cannot be before start date.");
                modelAndView.setViewName("leaveRequest");
                return modelAndView;
            }
            leaveRequest.setReason(reason);
            leaveRequest.setStatus("Pending");

            leaveRequestRepository.save(leaveRequest);
            modelAndView.setViewName("redirect:/dashboard?success=true");
            return modelAndView;
        } catch (DateTimeParseException e) {
            modelAndView.addObject("message", "Invalid date format. Please use YYYY-MM-DD.");
            modelAndView.setViewName("leaveRequest");
        } catch (Exception e) {
            modelAndView.addObject("message", "An error occurred while submitting the request. Please try again.");
            modelAndView.setViewName("leaveRequest"); // Giữ lại trang hiện tại nếu có lỗi

        }
        return modelAndView;
    }

    @GetMapping("/leaveHistory")
    public ModelAndView showLeaveHistory(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }

        List<LeaveRequest> personalRequests = new ArrayList<>();
        List<LeaveRequest> subordinateRequests = new ArrayList<>();

        // Lấy lịch sử bản thân
        personalRequests.addAll(leaveRequestRepository.findByUser_UserId(user.getUserId()));

        // Kiểm tra vai trò và mở rộng lịch sử cấp dưới, loại bỏ bản thân
        if ("Division Leader".equals(user.getRole())) {
            List<User> divisionUsers = userRepository.findAll();
            for (User u : divisionUsers) {
                if (u.getDivision() != null && u.getDivision().equals(user.getDivision()) && !(u.getUserId()==user.getUserId())) {
                    subordinateRequests.addAll(leaveRequestRepository.findByUser_UserId(u.getUserId()));
                }
            }
        } else {
            List<User> subordinates = userRepository.findByManagerId(user.getUserId());
            for (User subordinate : subordinates) {
                subordinateRequests.addAll(leaveRequestRepository.findByUser_UserId(subordinate.getUserId()));
            }
        }

        modelAndView.addObject("personalRequests", personalRequests);
        modelAndView.addObject("subordinateRequests", subordinateRequests);
        modelAndView.setViewName("leaveHistory");
        return modelAndView;
    }

    @GetMapping("/approveLeave")
    public ModelAndView showApproveLeave(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/dashboard");
            return modelAndView;
        }

        List<LeaveRequest> leaveRequests = new ArrayList<>();
        if ("admin".equals(user.getRole())) {
            leaveRequests = leaveRequestRepository.findAll(); // Admin thấy tất cả
        } else if ("Division Leader".equals(user.getRole())) {
            List<User> divisionUsers = userRepository.findAll(); // Lấy tất cả user trong division
            for (User u : divisionUsers) {
                if (u.getDivision().equals(user.getDivision())) {
                    leaveRequests.addAll(leaveRequestRepository.findByUser_UserId(u.getUserId()));
                }
            }
        } else if ("Team Leader".equals(user.getRole())) {
            List<User> subordinates = userRepository.findByManagerId(user.getUserId());
            for (User subordinate : subordinates) {
                leaveRequests.addAll(leaveRequestRepository.findByUser_UserId(subordinate.getUserId()));
            }
        } else {
            modelAndView.setViewName("redirect:/dashboard");
            return modelAndView;
        }

        modelAndView.addObject("leaveRequests", leaveRequests);
        modelAndView.setViewName("approveLeave");
        return modelAndView;
    }

    @PostMapping("/approveLeave")
    public ModelAndView processApproveLeave(@RequestParam("requestId") Integer requestId,
            @RequestParam("action") String action,
            HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/dashboard");
            return modelAndView;
        }

        LeaveRequest leaveRequest = leaveRequestRepository.findById(requestId).orElse(null);
        if (leaveRequest != null) {
            // Kiểm tra quyền phê duyệt
            boolean hasPermission = "admin".equals(user.getRole());
            if ("Division Leader".equals(user.getRole()) && leaveRequest.getUser().getDivision().equals(user.getDivision())) {
                hasPermission = true;
            } else if ("Team Leader".equals(user.getRole()) && leaveRequest.getUser().getManagerId() != null && leaveRequest.getUser().getManagerId().equals(user.getUserId())) {
                hasPermission = true;
            }

            if (hasPermission) {
                if ("approve".equals(action)) {
                    leaveRequest.setStatus("Approved");
                    leaveRequest.setProcessedBy(user.getUserId());
                } else if ("reject".equals(action)) {
                    leaveRequest.setStatus("Rejected");
                    leaveRequest.setProcessedBy(user.getUserId());
                }
                leaveRequestRepository.save(leaveRequest);
            }
        }
        modelAndView.setViewName("redirect:/approveLeave");
        return modelAndView;
    }

    @GetMapping("/register")
    public String showRegisterPage(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            return "redirect:/dashboard";
        }
        return "register";
    }

    @PostMapping("/register")
    public ModelAndView register(@RequestParam String username, @RequestParam String password,
            @RequestParam String division, @RequestParam String role,
            @RequestParam(required = false) Integer managerId, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard");
            return modelAndView;
        }

        if (userRepository.existsByUsername(username)) {
            modelAndView.addObject("message", "Username already exists. Please choose another.");
            modelAndView.setViewName("register");
            return modelAndView;
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPasswordHash(password);
        newUser.setRole(role); // Division Leader, Team Leader, Nhân Viên
        newUser.setDivision(division); // IT, QA, Sale
        newUser.setManagerId(managerId); // Null nếu là Division Leader
        userRepository.save(newUser);

        modelAndView.addObject("message", "Registration successful! User needs admin approval for role.");
        modelAndView.setViewName("register");
        return modelAndView;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
