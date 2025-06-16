<%-- 
    Document   : login
    Created on : Jun 13, 2025, 12:28:58 AM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ Thống Quản Lý Nghỉ Phép</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #4a90e2, #9013fe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-card h2 {
            margin-bottom: 20px;
            color: #4a90e2;
            font-size: 1.8em;
        }
        .login-card label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .login-card input[type="text"],
        .login-card input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .login-card input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #4a90e2, #9013fe);
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 1em;
            cursor: pointer;
            transition: background 0.3s;
        }
        .login-card input[type="submit"]:hover {
            background: linear-gradient(45deg, #357abd, #6b48ff);
        }
        .login-card .error {
            color: red;
            margin-top: 10px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Đăng nhập</h2>
        <form action="login" method="post">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required><br>
            <input type="submit" value="Đăng nhập">
        </form>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
</body>
</html>
