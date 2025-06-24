<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }
        .sidebar {
            width: 250px;
            background-color: #4a90e2;
            color: #fff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: all 0.3s;
            z-index: 100;
        }
        .sidebar.collapsed {
            width: 70px;
        }
        .sidebar .toggle-btn {
            background: none;
            border: none;
            color: #fff;
            font-size: 1.5rem;
            padding: 10px;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }
        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .sidebar .nav-menu li {
            padding: 15px 20px;
        }
        .sidebar .nav-menu li a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-menu li a i {
            margin-right: 10px;
        }
        .sidebar .nav-menu li a:hover {
            background-color: #357abd;
            border-radius: 5px;
        }
        .sidebar.collapsed .nav-menu li a span {
            display: none;
        }
        .sidebar.collapsed .nav-menu li a i {
            margin-right: 0;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s;
            flex-grow: 1;
        }
        .main-content.collapsed {
            margin-left: 70px;
        }
        .user-card {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        .user-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .user-card p {
            margin-bottom: 1rem;
            color: #666;
            font-size: 1rem;
        }
        .user-card .success {
            color: #28a745;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        .user-card a {
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
        .user-card a:hover {
            background: #357abd;
        }
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-250px);
            }
            .sidebar.collapsed {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .main-content.collapsed {
                margin-left: 0;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.toggle-btn');

            toggleBtn.addEventListener('click', function() {
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('collapsed');
            });
        });
    </script>
</head>
<body>
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
    <div class="main-content">
        <div class="user-card">
            <% 
                user = (User) session.getAttribute("user");
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
            <c:if test="${not empty user.fullname}">
                <p>Full Name: ${user.fullname}</p>
            </c:if>
            <c:if test="${not empty user.division}">
                <p>Division: ${user.division}</p>
            </c:if>
            <c:if test="${not empty user.managerId}">
                <p>Manager ID: ${user.managerId}</p>
            </c:if>
        </div>
    </div>
</body>
</html>