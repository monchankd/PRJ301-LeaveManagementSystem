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
            .request-card {
                background: #fff;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }
            .request-card h2 {
                margin-bottom: 1.5rem;
                color: #4a90e2;
                font-size: 1.75rem;
                font-weight: 700;
            }
            .request-card label {
                display: block;
                text-align: left;
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
        </style>
    </head>
    <body>
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
            <a href="dashboard" class="back-btn">Back</a>
        </div>
    </body>
</html>