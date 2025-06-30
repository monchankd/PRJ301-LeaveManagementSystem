<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Leave Request</title>
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
        .request-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            text-align: center;
        }
        .request-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .request-card label {
            display: block;
            margin-bottom: 0.5rem;
            color: #4a90e2;
            font-weight: 500;
            animation: slideIn 1s ease-out;
        }
        @keyframes slideIn {
            from { transform: translateX(-20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .request-card input[type="date"],
        .request-card textarea {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        .request-card input[type="date"]:focus,
        .request-card textarea:focus {
            border-color: #4a90e2;
            outline: none;
        }
        .request-card input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(45deg, #4a90e2, #9013fe);
            color: #fff;
            border: none;
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
        .request-card input[type="submit"]:hover {
            transform: scale(1.05);
            background: #357abd;
        }
        .request-card .message {
            color: #28a745;
            margin-top: 1rem;
            font-size: 0.9rem;
            animation: fadeIn 1s ease-in;
        }
        .request-card .back-btn {
            position: absolute;
            top: 1rem;
            left: 1rem;
            padding: 0.5rem 1rem;
            background: #6c757d;
            color: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            transition: transform 0.3s, background 0.3s;
            animation: bounceIn 1s ease-out;
        }
        @keyframes bounceIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .request-card .back-btn:hover {
            transform: scale(1.05);
            background: #5a6268;
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
            .request-card {
                padding: 1.5rem;
                max-width: 90%;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.toggle-btn');

            if (toggleBtn) {
                toggleBtn.addEventListener('click', function () {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('collapsed');
                });
            }
        });
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
    <div class="main-content">
        <div class="request-card">
            <h2>Submit Leave Request</h2>
            <form action="submitLeaveRequest" method="post">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required><br>
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required><br>
                <label for="reason">Reason:</label>
                <textarea id="reason" name="reason" rows="4" required></textarea><br>
                <input type="submit" value="Submit Request">
            </form>
            <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
            <% } %>
        </div>
    </div>
</body>
</html>