<%-- 
    Document   : register
    Created on : Jun 18, 2025, 4:20:53 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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
        .register-card {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .register-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .register-card label {
            display: block;
            text-align: left;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
        }
        .register-card input {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        .register-card input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background: #4a90e2;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .register-card input[type="submit"]:hover {
            background: #357abd;
        }
        .register-card .message {
            color: #28a745;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .register-card .error {
            color: #dc3545;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <h2>Register</h2>
        <form action="register" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" value="Register">
        </form>
        <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <p class="error"><%= request.getParameter("error") %></p>
        <% } %>
        <a href="login">Back to Login</a>
    </div>
</body>
</html>
