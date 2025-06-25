<%-- 
    Document   : leaveRequest
    Created on : Jun 16, 2025, 2:27:27 PM
    Author     : ASUS
--%>

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
            .request-card {
                background: #fff;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center; /* Center the text */
                margin-left: auto; /* Center the card horizontally */
                margin-right: auto; /* Center the card horizontally */
                position: relative;
            }
            .request-card h2 {
                margin-bottom: 1.5rem;
                color: #4a90e2;
                font-size: 1.75rem;
                font-weight: 700;
            }
            .request-card label {
                display: block;
                text-align: center; /* Center the labels */
                margin-bottom: 0.5rem;
                color: #333;
                font-weight: 500;
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
                text-align: center; /* Center the input text */
            }
            .request-card input[type="submit"] {
                width: 100%;
                padding: 0.75rem;
                background: #4a90e2;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s;
            }
            .request-card input[type="submit"]:hover {
                background: #357abd;
            }
            .request-card .message {
                color: #28a745;
                margin-top: 1rem;
                font-size: 0.9rem;
                text-align: center; /* Center the message */
            }
            .request-card .back-btn {
                position: absolute;
                top: 1rem;
                left: 1rem;
                width: auto; /* Allow natural width */
                padding: 0.5rem 1rem; /* Compact padding */
                background: #6c757d;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                font-size: 0.9rem;
                transition: background 0.3s;
            }
            .request-card .back-btn:hover {
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
                }
                .main-content.collapsed {
                    margin-left: 0;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const sidebar = document.querySelector('.sidebar');
                const mainContent = document.querySelector('.main-content');
                const toggleBtn = document.querySelector('.toggle-btn');

                toggleBtn.addEventListener('click', function () {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('collapsed');
                });
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