/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.companyx.leavemanagement.controller;

/**
 *
 * @author ASUS
 */
import com.companyx.leavemanagement.models.User;
import com.companyx.leavemanagement.models.UserRepository;
import jakarta.servlet.http.HttpSession;
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
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
