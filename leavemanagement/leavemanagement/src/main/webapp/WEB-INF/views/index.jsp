<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #4a90e2, #50e3c2);
            overflow: hidden;
            animation: gradientShift 10s ease infinite;
        }
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .index-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            text-align: center;
            animation: float 3s ease-in-out infinite;
            transform-origin: center;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .index-card h1 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }
        .index-card p {
            margin-bottom: 2rem;
            color: #666;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        .index-card a {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            margin: 0 0.5rem;
            background: #4a90e2;
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            transition: background 0.3s, transform 0.3s;
            position: relative;
            overflow: hidden;
        }
        .index-card a:hover {
            background: #357abd;
            transform: translateY(-2px);
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
            position: relative;
            overflow: hidden;
        }
        .login-btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }
        .login-btn:hover::after {
            width: 300px;
            height: 300px;
        }
        .login-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(74, 144, 226, 0.4);
        }
        @media (max-width: 480px) {
            .index-card {
                padding: 1.5rem;
                margin: 1rem;
            }
            .index-card h1 {
                font-size: 2rem;
            }
            .index-card p {
                font-size: 1rem;
            }
            .index-card a {
                display: block;
                margin: 0.5rem 0;
            }
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