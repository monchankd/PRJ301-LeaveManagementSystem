package main.java.com.companyx.leave_management.controller;

@Controller
public class LeaveRequestController {
    @GetMapping("/leave-requests/create")
    public String createLeaveRequestForm(Model model) {
        model.addAttribute("leaveRequest", new LeaveRequest());
        return "leave-request-form";
    }

    @PostMapping("/leave-requests/create")
    public String createLeaveRequest(@ModelAttribute LeaveRequest leaveRequest, Principal principal) {
        User user = userService.findByUsername(principal.getName());
        leaveRequest.setCreator(user);
        leaveRequest.setStatus(Status.INPROGRESS);
        leaveRequestService.save(leaveRequest);
        return "redirect:/leave-requests/my";
    }
}