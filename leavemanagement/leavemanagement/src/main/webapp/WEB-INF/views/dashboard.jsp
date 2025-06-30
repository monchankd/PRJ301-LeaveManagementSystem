<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow-x: hidden;
            background: linear-gradient(135deg, #4a90e2, #50e3c2);
            animation: gradientFlow 10s ease infinite;
        }
        @keyframes gradientFlow {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        body {
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #333;
        }
        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, #4a90e2, #357abd);
            color: #fff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: all 0.3s ease;
            z-index: 100;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
            animation: sidebarFade 1s ease-in-out;
        }
        @keyframes sidebarFade {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
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
            transition: color 0.3s;
        }
        .sidebar .toggle-btn:hover {
            color: #50e3c2;
        }
        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .sidebar .nav-menu li {
            padding: 15px 20px;
            transition: background 0.3s;
        }
        .sidebar .nav-menu li a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            display: flex;
            align-items: center;
            transition: color 0.3s;
        }
        .sidebar .nav-menu li a i {
            margin-right: 10px;
        }
        .sidebar .nav-menu li a:hover {
            color: #50e3c2;
        }
        .sidebar.collapsed .nav-menu li a span {
            display: none;
        }
        .sidebar.collapsed .nav-menu li a i {
            margin-right: 0;
        }
        .main-content {
            margin-left: 250px;
            padding: 30px;
            transition: all 0.3s ease;
            flex-grow: 1;
            overflow-x: hidden;
            box-sizing: border-box;
            position: relative;
        }
        .main-content.collapsed {
            margin-left: 70px;
        }
        .user-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            box-sizing: border-box;
        }
        .personal-info {
            margin-bottom: 2rem;
            text-align: left;
            padding: 1rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            animation: slideIn 1s ease-out;
        }
        @keyframes slideIn {
            from { transform: translateX(-20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .personal-info h2 {
            margin-bottom: 1rem;
            color: #4a90e2;
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .personal-info .details {
            max-height: 0;
            overflow: hidden;
            padding: 0 1rem;
            transition: max-height 0.3s ease-out, padding 0.3s ease-out;
        }
        .personal-info.active .details {
            max-height: 500px;
            padding: 1rem;
        }
        .personal-info p {
            margin: 0.5rem 0;
            color: #666;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        .personal-info p i {
            margin-right: 0.75rem;
            color: #4a90e2;
        }
        .personal-info .success {
            color: #28a745;
            margin: 0.5rem 0;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        .personal-info .success i {
            margin-right: 0.75rem;
            color: #28a745;
        }
        .personal-info .toggle-btn {
            background: linear-gradient(45deg, #4a90e2, #9013fe);
            color: #fff;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            cursor: pointer;
            transition: transform 0.3s, background 0.3s;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .personal-info .toggle-btn:hover {
            transform: scale(1.05);
            background: #357abd;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            overflow-x: auto;
            table-layout: fixed;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }
        .user-table th, .user-table td {
            padding: 0.75rem;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 1rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            box-sizing: border-box;
            transition: background 0.3s;
        }
        .user-table th {
            background: linear-gradient(90deg, #4a90e2, #357abd);
            color: #fff;
        }
        .user-table tr:hover td {
            background: #f0f8ff;
        }
        .user-table tr:nth-child(even) {
            background-color: #f2f2f2;
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
                padding: 15px;
            }
            .main-content.collapsed {
                margin-left: 0;
            }
            .user-table {
                width: 100vw;
                margin-left: -15px;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.toggle-btn');
            const personalToggle = document.querySelector('.personal-info .toggle-btn');
            const details = document.querySelector('.personal-info .details');

            if (toggleBtn) {
                toggleBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('collapsed');
                });
            }

            personalToggle.addEventListener('click', function() {
                const personalInfo = document.querySelector('.personal-info');
                personalInfo.classList.toggle('active');
                this.textContent = personalInfo.classList.contains('active') ? 'Hide Personal Info' : 'Show Personal Info';
            });
        });
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
    <div class="main-content">
        <div class="user-card">
            <div class="personal-info">
                <h2>Welcome!<span class="toggle-btn-container"><button class="toggle-btn">Show Personal Info</button></span></h2>
                <div class="details">
                    <% 
                        User user = (User) session.getAttribute("user");
                        if (user == null) {
                            response.sendRedirect("login");
                            return;
                        }
                        String success = request.getParameter("success");
                        if ("true".equals(success)) {
                    %>
                        <p class="success"><i class="fas fa-check-circle"></i> Leave request submitted successfully!</p>
                    <% } %>
                    <p><i class="fas fa-user"></i> Username: <%= user.getUsername() %></p>
                    <p><i class="fas fa-briefcase"></i> Role: <%= user.getRole() %></p>
                    <c:if test="${not empty user.fullname}">
                        <p><i class="fas fa-address-card"></i> Full Name: ${user.fullname}</p>
                    </c:if>
                    <c:if test="${not empty user.division}">
                        <p><i class="fas fa-building"></i> Division: ${user.division}</p>
                    </c:if>
                    <c:if test="${not empty user.managerId}">
                        <p><i class="fas fa-user-tie"></i> Manager ID: ${user.managerId}</p>
                    </c:if>
                </div>
            </div>
            <div class="user-table-container">
                <table class="user-table">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Division</th>
                    </tr>
                    <c:choose>
                        <c:when test="${user.role == 'admin'}">
                            <c:forEach var="u" items="${allUsers}">
                                <c:if test="${u.role != 'admin'}">
                                    <tr>
                                        <td>${u.userId}</td>
                                        <td>${u.fullname}</td>
                                        <td>${u.role}</td>
                                        <td>${u.division}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="u" items="${sameDivisionUsers}">
                                <c:if test="${u.role != 'admin'}">
                                    <tr>
                                        <td>${u.userId}</td>
                                        <td>${u.fullname}</td>
                                        <td>${u.role}</td>
                                        <td>${u.division}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </table>
            </div>
        </div>
    </div>
</body>
</html>