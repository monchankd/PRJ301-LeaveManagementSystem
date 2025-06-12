<%-- 
    Document   : dashboard
    Created on : Jun 13, 2025, 12:29:04 AM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trang chính</title>
</head>
<body>
    <% 
        models.User user = (models.User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <h2>Chào mừng, <%= user.getUsername() %>!</h2>
    <p>Vai trò của bạn là: <%= user.getRole() %></p>
    <a href="LogoutServlet">Đăng xuất</a>
</body>
</html>
