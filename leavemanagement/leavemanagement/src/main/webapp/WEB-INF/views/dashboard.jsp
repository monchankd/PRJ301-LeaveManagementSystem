<%-- 
    Document   : dashboard
    Created on : Jun 13, 2025, 12:29:04 AM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .dashboard-card {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .dashboard-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .dashboard-card p {
            margin-bottom: 1rem;
            color: #666;
            font-size: 1rem;
        }
        .dashboard-card a {
            display: block;
            padding: 0.75rem 1.5rem;
            margin: 0.5rem 0;
            background: #4a90e2;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s;
        }
        .dashboard-card a:hover {
            background: #357abd;
        }
        .dashboard-card .success {
            color: #28a745;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-card">
        <% 
            com.companyx.leavemanagement.models.User user = (com.companyx.leavemanagement.models.User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            String success = request.getParameter("success");
            if ("true".equals(success)) {
        %>
            <p class="success">Leave request submitted successfully!</p>
        <% } %>
        <h2>Welcome, <%= user.getUsername() %>!</h2>
        <p>Your role is: <%= user.getRole() %></p>
        <a href="submitLeaveRequest">Submit Leave Request</a>
        <a href="leaveHistory">View Leave History</a>
        <% if ("admin".equals(user.getRole()) || "Division Leader".equals(user.getRole()) || "Team Leader".equals(user.getRole())) { %>
            <a href="approveLeave">Approve Leave Requests</a>
        <% } %>
        <a href="logout">Logout</a>
    </div>
</body>
</html>