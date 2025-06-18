<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Management System</title>
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
            .index-card {
                background: #fff;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                text-align: center;
            }
            .index-card h1 {
                margin-bottom: 1.5rem;
                color: #4a90e2;
                font-size: 2rem;
                font-weight: 700;
            }
            .index-card p {
                margin-bottom: 2rem;
                color: #666;
                font-size: 1rem;
            }
            .index-card a {
                display: inline-block;
                padding: 0.75rem 1.5rem;
                background: #4a90e2;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                font-weight: 500;
                transition: background 0.3s;
            }
            .index-card a:hover {
                background: #357abd;
            }
            .login-btn {
                padding: 12px 30px;
                font-size: 1.1em;
                color: #fff;
                background: linear-gradient(45deg, #4a90e2, #9013fe);
                border: none;
                border-radius: 25px;
                cursor: pointer;
                text-decoration: none;
                transition: transform 0.3s, box-shadow 0.3s;
            }

        </style>

    </head>
    <body>
        <div class="index-card">
            <h1>Leave Management System</h1>
            <p>Please log in to access your account and manage leave requests.</p>
            <a href="login" class="login-btn">Login Now</a>
            <a href="register">Register</a>
        </div>
    </body>
</html>