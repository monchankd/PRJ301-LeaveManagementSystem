<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Approve Leave Requests</title>
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
                scrollbar-width: none; /* Firefox */
            }
            body {
                font-family: 'Roboto', sans-serif;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                color: #fff;
            }
            html::-webkit-scrollbar, body::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
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
            .approve-card {
                background: #222c3a;
                border-radius: 10px;
                padding: 20px 12px 24px 12px;
                width: 100%;
                color: #fff;
                box-shadow: 0 4px 24px rgba(0,0,0,0.2);
                margin: 16px auto 0 auto;
            }
            .approve-card h2 {
                text-align: center;
                color: #f7c873;
                margin-bottom: 18px;
            }
            .approve-table-container {
                overflow-x: auto;
            }
            .approve-table {
                width: 100%;
                background: #181f2a;
                color: #fff;
                border-radius: 8px;
            }
            .approve-table th, .approve-table td {
                padding: 0.75rem;
                border: 1px solid #222c3a;
                text-align: left;
                font-size: 1rem;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                box-sizing: border-box;
                transition: background 0.3s;
            }
            .approve-table th {
                background: linear-gradient(90deg, #4a90e2, #357abd);
                color: #fff;
            }
            .approve-table tr:hover td {
                background: #222c3a;
            }
            .approve-table td.status-Pending {
                background: #ffeb3b;
                color: #333;
                font-weight: 500;
            }
            .approve-table td.status-Approved {
                background: #28a745;
                color: #fff;
                font-weight: 500;
            }
            .approve-table td.status-Rejected {
                background: #dc3545;
                color: #fff;
                font-weight: 500;
            }
            .approve-table tr:hover td.status-Pending {
                color: #fff;
            }
            .approve-table tr:hover td.status-Approved {
                color: #fff;
            }
            .approve-table tr:hover td.status-Rejected {
                color: #fff;
            }
            .approve-table td.status-Pending {
                background: #ffeb3b;
                color: #333;
                font-weight: 500;
            }
            .approve-table td.status-Approved {
                background: #28a745;
                color: #fff;
                font-weight: 500;
            }
            .approve-table td.status-Rejected {
                background: #dc3545;
                color: #fff;
                font-weight: 500;
            }
            .approve-table td form {
                display: inline;
            }
            .approve-table input[type="submit"] {
                padding: 0.3rem 0.7rem;
                margin: 0 0.25rem;
                background: linear-gradient(45deg, #28a745, #218838);
                color: #fff;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                transition: transform 0.3s, background 0.3s;
            }
            .approve-table input[type="submit"].reject {
                background: linear-gradient(45deg, #dc3545, #c82333);
            }
            .approve-table input[type="submit"]:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.5);
            }
            .details-btn {
                background: linear-gradient(45deg, #4a90e2, #9013fe);
                color: #fff;
                border: none;
                padding: 0.3rem 0.7rem;
                border-radius: 20px;
                cursor: pointer;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .details-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 5px 15px rgba(74, 144, 226, 0.5);
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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const detailsButtons = document.querySelectorAll('.details-btn');
                const modal = document.getElementById('myModal');
                const closeBtn = document.querySelector('.close-btn');
                detailsButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const row = this.closest('tr');
                        document.getElementById('modal-start-date').textContent = row.querySelector('.start-date').textContent;
                        document.getElementById('modal-end-date').textContent = row.querySelector('.end-date').textContent;
                        document.getElementById('modal-request-id').textContent = row.getAttribute('data-request-id');
                        document.getElementById('modal-reason').textContent = row.getAttribute('data-reason');
                        document.getElementById('modal-status').textContent = row.querySelector('.status').textContent;
                        document.getElementById('modal-created-by').textContent = row.querySelector('td:first-child').textContent; // Username
                        document.getElementById('modal-processed-by').textContent = 'N/A'; // Not available in approve table
                        modal.style.display = 'flex';
                    });
                });
                closeBtn.addEventListener('click', function () {
                    modal.style.display = 'none';
                });
                window.addEventListener('click', function (event) {
                    if (event.target === modal) {
                        modal.style.display = 'none';
                    }
                });
            });
        </script>
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
                <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="User Info"><i class="fas fa-user"></i></button>
                <span style="color:#888;margin:0 8px;">|</span>
                <span style="color:#f7c873;">${user.username}</span>
                <div class="avatar">${user.username.substring(0,1)}</div>
            </div>
        </div>
        <div class="submenu">
            <a href="dashboard" class="tab-btn">Home</a>
            <a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
            <a href="leaveHistory" class="tab-btn">Leave History</a>
            <a href="approveLeave" class="nav-btn active">Approve</a>
            <c:if test="${user.role == 'Division Leader'}">
                <a href="agenda" class="nav-btn">Agenda</a>
            </c:if>
            <a href="profile" class="nav-btn">Profile</a>
        </div>
        <div class="main-content">
            <div class="center-panel">
                <div class="approve-card">
                    <h2>Approve Leave Requests</h2>
                    <div class="approve-table-container">
                        <table class="approve-table">
                            <tr>
                                <th>Username</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Action</th>
                                <th>Details</th>
                            </tr>
                            <c:forEach var="request" items="${leaveRequests}">
                                <tr data-request-id="${request.requestId}" data-reason="${request.reason}">
                                    <td>${request.user.username}</td>
                                    <td class="start-date">${request.startDate}</td>
                                    <td class="end-date">${request.endDate}</td>
                                    <td class="status status-${request.status}">${request.status}</td>
                                    <td>
                                        <c:if test="${request.status == 'Pending'}">
                                            <form action="approveLeave" method="post">
                                                <input type="hidden" name="requestId" value="${request.requestId}">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="submit" value="Approve">
                                            </form>
                                            <form action="approveLeave" method="post">
                                                <input type="hidden" name="requestId" value="${request.requestId}">
                                                <input type="hidden" name="action" value="reject">
                                                <input type="submit" class="reject" value="Reject">
                                            </form>
                                        </c:if>
                                        <c:if test="${request.status != 'Pending'}">
                                            -
                                        </c:if>
                                    </td>
                                    <td><button class="details-btn">Details</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
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
        <div id="myModal" class="modal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);justify-content:center;align-items:center;z-index:1000;">
            <div class="modal-content" style="background:#222c3a;padding:2rem;border-radius:15px;width:90%;max-width:550px;text-align:left;box-shadow:0 10px 30px rgba(0,0,0,0.2);color:#fff;">
                <button class="close-btn" style="background:#dc3545;color:#fff;border:none;padding:0.3rem 0.7rem;border-radius:20px;cursor:pointer;float:right;">Close</button>
                <h3>Leave Request Details</h3>
                <table class="modal-table" style="width:100%;border-collapse:collapse;margin-top:1rem;">
                    <tr><th>Request ID</th><td id="modal-request-id"></td></tr>
                    <tr><th>Start Date</th><td id="modal-start-date"></td></tr>
                    <tr><th>End Date</th><td id="modal-end-date"></td></tr>
                    <tr><th>Reason</th><td id="modal-reason"></td></tr>
                    <tr><th>Status</th><td id="modal-status"></td></tr>
                    <tr><th>Created By</th><td id="modal-created-by"></td></tr>
                    <tr><th>Processed By</th><td id="modal-processed-by"></td></tr>
                </table>
            </div>
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