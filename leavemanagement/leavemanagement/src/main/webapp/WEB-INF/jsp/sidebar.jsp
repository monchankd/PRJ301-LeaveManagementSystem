<%-- 
    Document   : sidebar
    Created on : Jun 26, 2025, 1:15:40 AM
    Author     : ASUS
--%>

<%-- WEB-INF/jsp/sidebar.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<div class="sidebar" id="sidebar">
    <button class="toggle-btn"><i class="fas fa-bars"></i></button>
    <ul class="nav-menu">
        <li><a href="dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
        <li><a href="submitLeaveRequest"><i class="fas fa-calendar"></i> <span>Submit Leave Request</span></a></li>
        <li><a href="leaveHistory"><i class="fas fa-history"></i> <span>View Leave History</span></a></li>
        <% 
            User user = (User) session.getAttribute("user");
            if (user != null && ("admin".equals(user.getRole()) || "Division Leader".equals(user.getRole()) || "Team Leader".equals(user.getRole()))) {
        %>
            <li><a href="approveLeave"><i class="fas fa-check"></i> <span>Approve Leave Requests</span></a></li>
        <% } %>
        <li><a href="logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
    </ul>
</div>
