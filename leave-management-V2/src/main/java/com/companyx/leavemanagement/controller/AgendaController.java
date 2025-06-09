package com.companyx.leavemanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AgendaController {

    @GetMapping("/agenda")
    public String showAgenda(Model model) {
        // Logic lấy dữ liệu nhân sự và trạng thái nghỉ phép
        // Giả sử trả về dữ liệu mẫu
        model.addAttribute("days", new String[]{"1/1", "2/1", "3/1", "4/1", "5/1"});
        model.addAttribute("employees", new String[]{"Mr A", "Mr B", "Mr C"});
        return "agenda";
    }
}