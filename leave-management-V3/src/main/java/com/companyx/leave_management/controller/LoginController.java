package main.java.com.companyx.leave_management.controller;

@Controller
public class LoginController {
    @GetMapping("/login")
    public String login() {
        return "login";
    }
}