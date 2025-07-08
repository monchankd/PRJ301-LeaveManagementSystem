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
            height: 100vh;
            overflow-x: hidden;
            overflow-y: hidden;
            background: #181f2a;
        }
        body {
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: #fff;
        }
        .navbar {
            display: flex;
            align-items: center;
            background: #181f2a;
            padding: 0 32px;
            height: 64px;
            border-bottom: 2px solid #222c3a;
        }
        .logo {
            width: 48px;
            height: 48px;
            background: #222c3a;
            border-radius: 8px;
            margin-right: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: bold;
            color: #f7c873;
        }
        .icon-bar {
            display: flex;
            gap: 16px;
            margin-right: 24px;
        }
        .icon-bar a { color: #fff; }
        .spacer { flex: 1; }
        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #2e3a4d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #f7c873;
        }
        .submenu {
            display: flex;
            background: #181f2a;
            border-bottom: 2px solid #222c3a;
            padding-left: 32px;
            height: 56px;
            align-items: center;
            gap: 8px;
        }
        .tab-btn, .nav-btn {
            background: none;
            border: 2px solid transparent;
            color: #f7c873;
            font-size: 17px;
            margin-right: 12px;
            cursor: pointer;
            padding: 10px 22px;
            border-radius: 12px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: background 0.25s, color 0.25s, box-shadow 0.25s, border 0.25s;
            box-shadow: 0 2px 8px 0 rgba(0,0,0,0.04);
            position: relative;
            z-index: 1;
        }
        .tab-btn.active, .nav-btn.active {
            background: linear-gradient(90deg, #4a90e2 60%, #f7c873 100%);
            color: #181f2a;
            border: 2px solid #f7c873;
            box-shadow: 0 4px 16px 0 rgba(247,200,115,0.18);
        }
        .tab-btn:hover, .nav-btn:hover {
            background: #222c3a;
            color: #f7c873;
            border: 2px solid #4a90e2;
            box-shadow: 0 2px 12px 0 rgba(74,144,226,0.18);
        }
        .main-content {
            display: flex;
            height: calc(100vh - 112px);
            min-width: 0;
            padding: 0;
            margin-left: 0;
            overflow: hidden;
        }
        .right-panel {
            height: 100%;
            min-height: 0;
            width: 260px;
            min-width: 260px;
            max-width: 260px;
            background: #181f2a;
            padding: 32px 16px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .center-panel {
            flex: 1 1 0;
            min-width: 0;
            padding: 32px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: rgba(24,31,42,0.95);
        }
        .clash-logo {
            width: 100px;
            height: 100px;
            background: #222c3a;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #f7c873;
            margin-bottom: 16px;
        }
        .score {
            font-size: 32px;
            color: #f7c873;
            margin-bottom: 8px;
        }
        .score-label {
            color: #b0b8c1;
            margin-bottom: 24px;
        }
        .add-btn {
            background: #f7c873;
            color: #222c3a;
            border: none;
            border-radius: 6px;
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 8px;
        }
        nav {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 12px;
            align-items: flex-start;
        }
        nav a {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 6px;
            transition: background 0.2s;
        }
        nav a:hover {
            background: #222c3a;
            color: #f7c873;
        }
        .leave-form-card {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            background: #222c3a;
            border-radius: 10px;
            padding: 32px 24px;
            color: #fff;
            box-shadow: 0 4px 24px rgba(0,0,0,0.2);
        }
        .leave-form-card h2 {
            text-align: center;
            color: #f7c873;
            margin-bottom: 24px;
        }
        .leave-form-card label {
            margin-bottom: 4px;
        }
        .leave-form-card input[type="date"],
        .leave-form-card textarea {
            width: 100%;
            margin-bottom: 12px;
            padding: 8px;
            border: 1px solid #2e3a4d;
            border-radius: 4px;
            background: #181f2a;
            color: #fff;
        }
        .leave-form-card button[type="submit"] {
            width: 100%;
            background: #f7c873;
            color: #222c3a;
            font-weight: bold;
            padding: 10px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .right-panel .division-list {
            width: 100%;
            margin-top: 16px;
        }
        .friend {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            color: #fff;
            font-size: 15px;
            gap: 10px;
        }
        .friend .status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 6px;
            background: #00ff99;
        }
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background: #181f2a;
            color: #ccc;
            font-size: 13px;
            padding: 6px 32px;
            border-top: 1px solid #222c3a;
            z-index: 10;
            }
        .message {
            background: #f44336;
            color: white;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</head>
<body style="margin:0;">
  <div class="navbar">
    <div class="logo">L</div>
    <div class="icon-bar">
      <a href="dashboard" title="Dashboard"><i class="fas fa-tachometer-alt"></i></a>
      <a href="submitLeaveRequest" title="Submit Leave Request"><i class="fas fa-calendar"></i></a>
      <a href="leaveHistory" title="Leave History"><i class="fas fa-history"></i></a>
      <c:if test="${user.role == 'admin' || user.role == 'Division Leader' || user.role == 'Team Leader'}">
        <a href="approveLeave" title="Approve"><i class="fas fa-check"></i></a>
      </c:if>
      <a href="logout" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
    </div>
    <div class="spacer"></div>
    <div class="user-info" style="display:flex;align-items:center;gap:8px;">
      <button id="theme-toggle" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Chuyển đổi sáng/tối"><i id="theme-toggle-icon" class="fas fa-moon"></i></button>
      <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Settings"><i class="fas fa-cog"></i></button>
      <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="User Info"><i class="fas fa-user"></i></button>
      <span style="color:#888;margin:0 8px;">|</span>
      <span style="color:#f7c873;">${user.username}</span>
      <div class="avatar" style="width:40px;height:40px;border-radius:50%;background:#2e3a4d;display:flex;align-items:center;justify-content:center;font-size:20px;color:#f7c873;">${user.username.substring(0,1)}</div>
    </div>
  </div>
  <div class="submenu">
    <a href="dashboard" class="tab-btn">Home</a>
    <a href="submitLeaveRequest" class="tab-btn active">Submit Leave Request</a>
    <a href="leaveHistory" class="tab-btn">Leave History</a>
    <c:if test="${user.role == 'admin' || user.role == 'Division Leader' || user.role == 'Team Leader'}">
      <a href="approveLeave" class="nav-btn">Approve</a>
    </c:if>
    <c:if test="${user.role == 'Division Leader'}">
      <a href="agenda" class="nav-btn">Agenda</a>
    </c:if>
    <a href="profile" class="nav-btn">Profile</a>
  </div>
    <div class="main-content">
    <div class="center-panel">
      <div class="leave-form-card">
            <h2>Submit Leave Request</h2>
        <c:if test="${not empty message}">
          <div class="message">${message}</div>
        </c:if>
            <form action="submitLeaveRequest" method="post">
          <label style="margin-bottom:4px;">Start Date:</label>
          <input type="date" name="startDate" required style="width:100%;margin-bottom:12px;">
          <label style="margin-bottom:4px;">End Date:</label>
          <input type="date" name="endDate" required style="width:100%;margin-bottom:12px;">
          <label style="margin-bottom:4px;">Reason:</label>
          <textarea name="reason" required style="width:100%;margin-bottom:16px;"></textarea>
          <button type="submit">Submit</button>
            </form>
      </div>
    </div>
    <div class="right-panel">
      <div style="font-weight:bold; margin-bottom:10px; color:#f7c873;">DIVISION MEMBERS</div>
      <div class="division-list">
        <c:forEach var="member" items="${sameDivisionUsers}">
          <c:if test="${member.role != 'admin'}">
            <div class="friend online">
              <span class="status-dot"></span>
              ${member.fullname}
            </div>
          </c:if>
        </c:forEach>
        </div>
    </div>
  </div>
  <div class="footer">
    </div>
  <script>
    // Theme toggle logic
    const themeToggle = document.getElementById('theme-toggle');
    const themeIcon = document.getElementById('theme-toggle-icon');
    function setTheme(dark) {
      if (dark) {
        document.body.style.background = '#181f2a';
        document.body.classList.add('dark-mode');
        themeIcon.classList.remove('fa-moon');
        themeIcon.classList.add('fa-sun');
      } else {
        document.body.style.background = '';
        document.body.classList.remove('dark-mode');
        themeIcon.classList.remove('fa-sun');
        themeIcon.classList.add('fa-moon');
      }
      localStorage.setItem('darkMode', dark ? '1' : '0');
    }
    themeToggle.addEventListener('click', function() {
      const isDark = !document.body.classList.contains('dark-mode');
      setTheme(isDark);
    });
    // On load
    if (localStorage.getItem('darkMode') === '1') setTheme(true);
  </script>
</body>
</html>