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
import java.util.Map;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

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
    public ModelAndView showDashboard(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }

        // Add user to model for display in JSP
        modelAndView.addObject("user", user);

        // Lấy lịch sử bản thân
        List<LeaveRequest> personalRequests = new ArrayList<>();
        List<LeaveRequest> subordinateRequests = new ArrayList<>();
        personalRequests.addAll(leaveRequestRepository.findByUser_UserId(user.getUserId()));

        // Lấy lịch sử cấp dưới (tối ưu N+1 query)
        List<Integer> subordinateUserIds = new ArrayList<>();
        if ("Division Leader".equals(user.getRole())) {
            List<User> divisionUsers = userRepository.findAll();
            for (User u : divisionUsers) {
                if (u.getDivision() != null && u.getDivision().equals(user.getDivision()) && !(u.getUserId() == user.getUserId()) && !"admin".equals(u.getRole())) {
                    subordinateUserIds.add(u.getUserId());
                }
            }
        } else {
            List<User> subordinates = userRepository.findByManagerId(user.getUserId());
            for (User subordinate : subordinates) {
                subordinateUserIds.add(subordinate.getUserId());
            }
        }
        if (!subordinateUserIds.isEmpty()) {
            subordinateRequests = leaveRequestRepository.findByUser_UserIdIn(subordinateUserIds);
        }

        // Thêm fullname cho createdBy và processedBy
        for (LeaveRequest request : personalRequests) {
            request.setCreatedByFullname(getFullname(request.getCreatedBy()));
            request.setProcessedByFullname(getFullname(request.getProcessedBy()));
        }
        for (LeaveRequest request : subordinateRequests) {
            request.setCreatedByFullname(getFullname(request.getCreatedBy()));
            request.setProcessedByFullname(getFullname(request.getProcessedBy()));
        }

        modelAndView.addObject("personalRequests", personalRequests);
        modelAndView.addObject("subordinateRequests", subordinateRequests);

        // Populate user list based on role
        if ("admin".equals(user.getRole())) {
            modelAndView.addObject("allUsers", userRepository.findAll());
        } else if(!"admin".equals(user.getRole())) {
            modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
        }

        if ("admin".equals(user.getRole())) {
            modelAndView.setViewName("dashboard");
            return modelAndView;
        }
        modelAndView.setViewName("dashboard");
        return modelAndView;
    }

    @GetMapping("/submitLeaveRequest")
    public ModelAndView showLeaveRequestForm(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }

        // Add user to model for display in JSP
        modelAndView.addObject("user", user);

        // Populate user list based on role
        if ("admin".equals(user.getRole())) {
            modelAndView.addObject("sameDivisionUsers", userRepository.findAll());
        } else if(!"admin".equals(user.getRole())) {
            modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
        }

        if ("admin".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }
        modelAndView.setViewName("leaveRequest");
        return modelAndView;
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
            modelAndView.addObject("user", user);
            if ("admin".equals(user.getRole())) {
                modelAndView.addObject("sameDivisionUsers", userRepository.findAll());
            } else if(!"admin".equals(user.getRole())) {
                modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
            }
            modelAndView.setViewName("leaveRequest");
        } catch (Exception e) {
            modelAndView.addObject("message", "An error occurred while submitting the request. Please try again.");
            modelAndView.addObject("user", user);
            if ("admin".equals(user.getRole())) {
                modelAndView.addObject("sameDivisionUsers", userRepository.findAll());
            } else if(!"admin".equals(user.getRole())) {
                modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
            }
            modelAndView.setViewName("leaveRequest"); // Giữ lại trang hiện tại nếu có lỗi
        }
        return modelAndView;
    }

    @GetMapping("/leaveHistory")
    public ModelAndView showLeaveHistory(HttpSession session,
                                         @RequestParam(value = "personalPage", defaultValue = "1") int personalPage,
                                         @RequestParam(value = "subordinatePage", defaultValue = "1") int subordinatePage,
                                         @RequestParam(value = "pageSize", defaultValue = "5") int pageSize) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }

        // Personal requests pagination
        Pageable personalPageable = PageRequest.of(personalPage - 1, pageSize);
        Page<LeaveRequest> personalRequestPage = leaveRequestRepository.findByUser_UserId(user.getUserId(), personalPageable);
        List<LeaveRequest> personalRequests = personalRequestPage.getContent();
        int personalTotalPages = personalRequestPage.getTotalPages();

        // Subordinate requests pagination (phân trang SQL)
        List<Integer> subordinateUserIds = new ArrayList<>();
        if ("Division Leader".equals(user.getRole())) {
            List<User> divisionUsers = userRepository.findAll();
            for (User u : divisionUsers) {
                if (u.getDivision() != null && u.getDivision().equals(user.getDivision()) && !(u.getUserId() == user.getUserId()) && !"admin".equals(u.getRole())) {
                    subordinateUserIds.add(u.getUserId());
                }
            }
        } else {
            List<User> subordinates = userRepository.findByManagerId(user.getUserId());
            for (User subordinate : subordinates) {
                subordinateUserIds.add(subordinate.getUserId());
            }
        }
        Page<LeaveRequest> subordinateRequestPage = Page.empty();
        List<LeaveRequest> subordinateRequests = new ArrayList<>();
        int subordinateTotalPages = 0;
        if (!subordinateUserIds.isEmpty()) {
            Pageable subordinatePageable = PageRequest.of(subordinatePage - 1, pageSize);
            subordinateRequestPage = leaveRequestRepository.findByUser_UserIdIn(subordinateUserIds, subordinatePageable);
            subordinateRequests = subordinateRequestPage.getContent();
            subordinateTotalPages = subordinateRequestPage.getTotalPages();
        }

        // Thêm fullname cho createdBy và processedBy
        for (LeaveRequest request : personalRequests) {
            request.setCreatedByFullname(getFullname(request.getCreatedBy()));
            request.setProcessedByFullname(getFullname(request.getProcessedBy()));
        }
        for (LeaveRequest request : subordinateRequests) {
            request.setCreatedByFullname(getFullname(request.getCreatedBy()));
            request.setProcessedByFullname(getFullname(request.getProcessedBy()));
        }

        modelAndView.addObject("personalRequests", personalRequests);
        modelAndView.addObject("personalPage", personalPage);
        modelAndView.addObject("personalTotalPages", personalTotalPages);
        modelAndView.addObject("subordinateRequests", subordinateRequests);
        modelAndView.addObject("subordinatePage", subordinatePage);
        modelAndView.addObject("subordinateTotalPages", subordinateTotalPages);
        modelAndView.addObject("pageSize", pageSize);
        if ("admin".equals(user.getRole())) {
            modelAndView.addObject("sameDivisionUsers", userRepository.findAll());
        } else {
            modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
        }
        if ("admin".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }
        modelAndView.setViewName("leaveHistory");
        return modelAndView;
    }

    private String getFullname(Integer userId) {
        if (userId == null) {
            return "-";
        }
        return userRepository.findById(userId).map(User::getFullname).orElse("Unknown");
    }

    @GetMapping("/approveLeave")
    public ModelAndView showApproveLeave(HttpSession session,
                                         @RequestParam(value = "page", defaultValue = "1") int page,
                                         @RequestParam(value = "pageSize", defaultValue = "5") int pageSize) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }

        // 1. showApproveLeave: Nếu không phải Division Leader hoặc Team Leader thì redirect:/dashboard?denied=true
        if (!"Division Leader".equals(user.getRole()) && !"Team Leader".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }

        Page<LeaveRequest> leaveRequestPage = Page.empty();
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        int totalPages = 0;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        if ("admin".equals(user.getRole())) {
            leaveRequestPage = leaveRequestRepository.findAll(pageable);
        } else if ("Division Leader".equals(user.getRole())) {
            List<User> divisionUsers = userRepository.findAll();
            List<Integer> subordinateUserIds = new ArrayList<>();
            for (User u : divisionUsers) {
                if (u.getDivision() != null && u.getDivision().equals(user.getDivision()) && !"admin".equals(u.getRole())) {
                    subordinateUserIds.add(u.getUserId());
                }
            }
            if (!subordinateUserIds.isEmpty()) {
                leaveRequestPage = leaveRequestRepository.findByUser_UserIdIn(subordinateUserIds, pageable);
            }
        } else if ("Team Leader".equals(user.getRole())) {
            List<User> subordinates = userRepository.findByManagerId(user.getUserId());
            List<Integer> subordinateUserIds = new ArrayList<>();
            for (User subordinate : subordinates) {
                subordinateUserIds.add(subordinate.getUserId());
            }
            if (!subordinateUserIds.isEmpty()) {
                leaveRequestPage = leaveRequestRepository.findByUser_UserIdIn(subordinateUserIds, pageable);
            }
        } else {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }
        leaveRequests = leaveRequestPage.getContent();
        totalPages = leaveRequestPage.getTotalPages();

        modelAndView.addObject("leaveRequests", leaveRequests);
        modelAndView.addObject("page", page);
        modelAndView.addObject("totalPages", totalPages);
        modelAndView.addObject("pageSize", pageSize);
        if ("admin".equals(user.getRole())) {
            modelAndView.addObject("sameDivisionUsers", userRepository.findAll());
        } else {
            modelAndView.addObject("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
        }
        if ("admin".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }
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
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }

        // 2. processApproveLeave: Nếu không phải Division Leader hoặc Team Leader thì redirect:/dashboard?denied=true
        if (!"Division Leader".equals(user.getRole()) && !"Team Leader".equals(user.getRole())) {
            modelAndView.setViewName("redirect:/dashboard?denied=true");
            return modelAndView;
        }

        LeaveRequest leaveRequest = leaveRequestRepository.findById(requestId).orElse(null);
        if (leaveRequest != null) {
            // Kiểm tra quyền phê duyệt
            boolean hasPermission = "admin".equals(user.getRole());
            if ("Division Leader".equals(user.getRole()) && leaveRequest.getUser().getDivision() != null
                    && leaveRequest.getUser().getDivision().equals(user.getDivision()) && !"admin".equals(leaveRequest.getUser().getRole())) {
                hasPermission = true;
            } else if ("Team Leader".equals(user.getRole()) && leaveRequest.getUser().getManagerId() != null
                    && leaveRequest.getUser().getManagerId().equals(user.getUserId())) {
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
            // 3. showRegisterPage, register: Nếu không phải admin thì redirect:/dashboard?denied=true
            return "redirect:/dashboard?denied=true";
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
            // 3. showRegisterPage, register: Nếu không phải admin thì redirect:/dashboard?denied=true
            modelAndView.setViewName("redirect:/dashboard?denied=true");
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

    @GetMapping("/profile")
    public ModelAndView showProfile(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }
        modelAndView.addObject("user", user);
        if ("admin".equals(user.getRole())) {
            modelAndView.setViewName("profile");
            return modelAndView;
        }
        modelAndView.setViewName("profile");
        return modelAndView;
    }

    @GetMapping("/agenda")
    public String agendaPage(@RequestParam(value = "fromDate", required = false) String fromDate,
                            @RequestParam(value = "toDate", required = false) String toDate,
                            Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"Division Leader".equals(user.getRole())) {
            // 4. agendaPage: Nếu không phải Division Leader thì redirect:/dashboard?denied=true
            return "redirect:/dashboard?denied=true";
        }
        // Bổ sung logic mặc định cho fromDate và toDate
        LocalDate start, end;
        if (fromDate == null || toDate == null) {
            start = LocalDate.now();
            end = start.plusDays(7);
            fromDate = start.toString();
            toDate = end.toString();
        } else {
            start = LocalDate.parse(fromDate);
            end = LocalDate.parse(toDate);
        }
        List<String> dateHeaders = new ArrayList<>();
        List<Map<String, Object>> agendaMatrix = new ArrayList<>();
        for (LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
            dateHeaders.add(d.getDayOfMonth() + "/" + d.getMonthValue());
        }
        List<User> members = userRepository.findByDivision(user.getDivision());
        for (User member : members) {
            if ("admin".equals(member.getRole())) continue;
            Map<String, Object> row = new HashMap<>();
            row.put("name", member.getFullname());
            List<Map<String, String>> cells = new ArrayList<>();
            List<LeaveRequest> leaves = leaveRequestRepository.findByUser_UserId(member.getUserId());
            for (LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
                boolean isLeave = false;
                for (LeaveRequest leave : leaves) {
                    if (leave.getStatus().equals("Approved") &&
                        (d.compareTo(leave.getStartDate()) >= 0 && d.compareTo(leave.getEndDate()) <= 0)) {
                        isLeave = true;
                        break;
                    }
                }
                Map<String, String> cell = new HashMap<>();
                cell.put("status", isLeave ? "leave" : "working");
                cells.add(cell);
            }
            row.put("cells", cells);
            agendaMatrix.add(row);
        }
        model.addAttribute("dateHeaders", dateHeaders);
        model.addAttribute("agendaMatrix", agendaMatrix);
        model.addAttribute("sameDivisionUsers", userRepository.findByDivision(user.getDivision()));
        // Truyền thêm fromDate, toDate sang view
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        return "agenda";
    }

    @PostMapping("/changePassword")
    public ModelAndView changePassword(@RequestParam("oldPassword") String oldPassword,
                                       @RequestParam("newPassword") String newPassword,
                                       HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            modelAndView.setViewName("redirect:/login");
            return modelAndView;
        }
        // Kiểm tra mật khẩu cũ
        if (!user.getPasswordHash().equals(oldPassword)) { // Nếu có mã hóa, cần giải mã
            modelAndView.addObject("changePasswordError", "Mật khẩu cũ không đúng!");
            modelAndView.addObject("user", user);
            modelAndView.setViewName("dashboard");
            return modelAndView;
        }
        // Đổi mật khẩu
        user.setPasswordHash(newPassword); // Nếu có mã hóa, cần mã hóa newPassword
        userRepository.save(user);
        session.setAttribute("user", user); // Cập nhật lại session
        modelAndView.addObject("changePasswordSuccess", "Đổi mật khẩu thành công!");
        modelAndView.addObject("user", user);
        modelAndView.setViewName("dashboard");
        return modelAndView;
    }
}


