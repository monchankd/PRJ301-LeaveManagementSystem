<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agenda</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            html, body {
                margin: 0;
                padding: 0;
                min-height: 100vh;
                height: auto;
                overflow-x: hidden;
                overflow-y: auto;
                background: #181f2a;
                scrollbar-width: none;
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
                min-height: 100vh;
                min-width: 0;
                padding: 0;
                margin-left: 0;
                overflow: visible;
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
                padding: 16px 40px 24px 40px;
                display: block;
                background: rgba(24,31,42,0.95);
            }
            .agenda-card {
                background: #222c3a;
                border-radius: 10px;
                padding: 20px 12px 24px 12px;
                width: 100%;
                color: #fff;
                box-shadow: 0 4px 24px rgba(0,0,0,0.2);
                margin: 16px auto 0 auto;
            }
            .agenda-card h2 {
                text-align: center;
                color: #f7c873;
                margin-bottom: 18px;
            }
            .filter-row {
                display: flex;
                gap: 16px;
                margin-bottom: 24px;
                align-items: center;
            }
            .filter-row label { color: #f7c873; }
            .filter-row input[type="date"] {
                background: #181f2a;
                color: #fff;
                border: 1px solid #2e3a4d;
                border-radius: 4px;
                padding: 6px 12px;
            }
            .filter-row button {
                background: #f7c873;
                color: #222c3a;
                border: none;
                border-radius: 6px;
                padding: 8px 18px;
                font-weight: bold;
                cursor: pointer;
            }
            .agenda-table-container {
                overflow-x: auto;
            }
            .agenda-table {
                width: 100%;
                background: #181f2a;
                color: #fff;
                border-radius: 8px;
                border-collapse: collapse;
            }
            .agenda-table th, .agenda-table td {
                padding: 0.75rem;
                border: 1px solid #222c3a;
                text-align: center;
                font-size: 1rem;
                min-width: 60px;
            }
            .agenda-table th {
                background: linear-gradient(90deg, #4a90e2, #357abd);
                color: #fff;
            }
            .agenda-table tr:hover td {
                background: #2e3a4d;
                color: #fff;
                border-top: 2px solid #4a90e2;
                border-bottom: 2px solid #4a90e2;
            }
            .agenda-table tr:hover td.cell-leave {
                background: #ff4d4d;
                color: #fff;
                border: 2px solid #f7c873;
                box-shadow: 0 0 8px 2px #f7c87355;
                z-index: 1;
            }
            .cell-working {
                background: #7ed957;
                color: #222c3a;
                font-weight: bold;
            }
            .cell-leave {
                background: #dc3545;
                color: #fff;
                font-weight: bold;
            }
            .agenda-table td.name-cell {
                background: #fff;
                color: #222c3a;
                font-weight: bold;
            }
            .division-list {
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
            
            /* User profile button hover effect */
            .user-info button:hover {
                color: #f7c873 !important;
                transform: scale(1.1);
                transition: all 0.3s ease;
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
            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                }
                .right-panel {
                    width: 100%;
                    max-width: 100%;
                    min-width: 0;
                    padding: 16px 8px;
                }
                .center-panel {
                    padding: 16px 8px;
                }
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
            <div class="user-info">
                <button id="theme-toggle" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Chuyển đổi sáng/tối"><i id="theme-toggle-icon" class="fas fa-moon"></i></button>
                <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Settings"><i class="fas fa-cog"></i></button>
                <button onclick="window.location.href='profile'" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="User Profile"><i class="fas fa-user"></i></button>
                <span style="color:#888;margin:0 8px;">|</span>
                <span style="color:#f7c873;">${user.username}</span>
                <div class="avatar">${user.username.substring(0,1)}</div>
            </div>
        </div>
        <div class="submenu">
            <a href="dashboard" class="tab-btn">Home</a>
            <a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
            <a href="leaveHistory" class="tab-btn">Leave History</a>
            <a href="approveLeave" class="nav-btn">Approve</a>
            <c:if test="${user.role == 'Division Leader'}">
                <a href="agenda" class="nav-btn active">Agenda</a>
            </c:if>
            <a href="profile" class="nav-btn">Profile</a>
        </div>
        <div class="main-content">
            <div class="center-panel">
                <div class="agenda-card">
                    <h2>Division Agenda Overview</h2>
                    <form class="filter-row" method="get" action="agenda">
                        <label>From: <input type="date" name="fromDate" value="${param.fromDate}" required></label>
                        <label>To: <input type="date" name="toDate" value="${param.toDate}" required></label>
                        <button type="submit">Filter</button>
                    </form>
                    <div class="agenda-table-container">
                        <table class="agenda-table">
                            <tr>
                                <th>Nhân sự</th>
                                <c:forEach var="date" items="${dateHeaders}">
                                    <th>${date}</th>
                                </c:forEach>
                            </tr>
                            <c:forEach var="row" items="${agendaMatrix}">
                                <tr>
                                    <td class="name-cell">${row.name}</td>
                                    <c:forEach var="cell" items="${row.cells}">
                                        <td class="cell-${cell.status}"></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <c:if test="${empty agendaMatrix}">
                        <div style="text-align:center;color:#f44336;margin-top:24px;">No data for the selected period.</div>
                    </c:if>
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
        <div class="footer"></div>
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