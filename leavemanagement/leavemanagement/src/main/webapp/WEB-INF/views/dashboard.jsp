<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
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
            color: #333;
        }
        .sidebar {
            width: 250px;
            background: #181f2a;
            color: #fff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: all 0.3s ease;
            z-index: 100;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
            animation: sidebarFade 1s ease-in-out;
        }
        @keyframes sidebarFade {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
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
            transition: color 0.3s;
        }
        .sidebar .toggle-btn:hover {
            color: #50e3c2;
        }
        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .sidebar .nav-menu li {
            padding: 15px 20px;
            transition: background 0.3s;
        }
        .sidebar .nav-menu li a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            display: flex;
            align-items: center;
            transition: color 0.3s;
        }
        .sidebar .nav-menu li a i {
            margin-right: 10px;
        }
        .sidebar .nav-menu li a:hover {
            color: #50e3c2;
        }
        .sidebar.collapsed .nav-menu li a span {
            display: none;
        }
        .sidebar.collapsed .nav-menu li a i {
            margin-right: 0;
        }
        .main-content {
            display: flex;
            height: calc(100vh - 112px);
            min-width: 0;
            padding: 0;
            margin-left: 0;
            overflow: hidden;
        }
        .main-content.collapsed {
            margin-left: 70px;
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
        .web-info-card {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
            background:#222c3a;
            border-radius:10px;
            padding:32px 24px;
            color:#fff;
            box-shadow:0 4px 24px rgba(0,0,0,0.2);
            text-align:center;
        }
        .user-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            box-sizing: border-box;
        }
        .personal-info {
            margin-bottom: 2rem;
            text-align: left;
            padding: 1rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            animation: slideIn 1s ease-out;
        }
        @keyframes slideIn {
            from { transform: translateX(-20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        .personal-info h2 {
            margin-bottom: 1rem;
            color: #4a90e2;
            font-size: 2rem;
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeIn 1s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .personal-info .details {
            max-height: 0;
            overflow: hidden;
            padding: 0 1rem;
            transition: max-height 0.3s ease-out, padding 0.3s ease-out;
        }
        .personal-info.active .details {
            max-height: 500px;
            padding: 1rem;
        }
        .personal-info p {
            margin: 0.5rem 0;
            color: #666;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        .personal-info p i {
            margin-right: 0.75rem;
            color: #4a90e2;
        }
        .personal-info .success {
            color: #28a745;
            margin: 0.5rem 0;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }
        .personal-info .success i {
            margin-right: 0.75rem;
            color: #28a745;
        }
        .personal-info .toggle-btn {
            background: linear-gradient(45deg, #4a90e2, #9013fe);
            color: #fff;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            cursor: pointer;
            transition: transform 0.3s, background 0.3s;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .personal-info .toggle-btn:hover {
            transform: scale(1.05);
            background: #357abd;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            overflow-x: auto;
            table-layout: fixed;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }
        .user-table th, .user-table td {
            padding: 0.75rem;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 1rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            box-sizing: border-box;
            transition: background 0.3s;
        }
        .user-table th {
            background: linear-gradient(90deg, #4a90e2, #357abd);
            color: #fff;
        }
        .user-table tr:hover td {
            background: #f0f8ff;
        }
        .user-table tr:nth-child(even) {
            background-color: #f2f2f2;
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
                padding: 15px;
            }
            .main-content.collapsed {
                margin-left: 0;
            }
            .user-table {
                width: 100vw;
                margin-left: -15px;
            }
        }
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            z-index: 10;
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
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.toggle-btn');
            const personalToggle = document.querySelector('.personal-info .toggle-btn');
            const details = document.querySelector('.personal-info .details');

            if (toggleBtn) {
                toggleBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('collapsed');
                });
            }

            personalToggle.addEventListener('click', function() {
                const personalInfo = document.querySelector('.personal-info');
                personalInfo.classList.toggle('active');
                this.textContent = personalInfo.classList.contains('active') ? 'Hide Personal Info' : 'Show Personal Info';
            });
        });
    </script>
</head>
<body style="margin:0;">
  <div class="navbar" style="display:flex;align-items:center;background:#181f2a;padding:0 32px;height:64px;border-bottom:2px solid #222c3a;">
    <div class="logo" style="width:48px;height:48px;background:#222c3a;border-radius:8px;margin-right:24px;display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:bold;color:#f7c873;">L</div>
    <div class="icon-bar" style="display:flex;gap:16px;margin-right:24px;">
      <a href="dashboard" title="Dashboard" style="color:#fff;"><i class="fas fa-tachometer-alt"></i></a>
      <a href="submitLeaveRequest" title="Submit Leave Request" style="color:#fff;"><i class="fas fa-calendar"></i></a>
      <a href="leaveHistory" title="Leave History" style="color:#fff;"><i class="fas fa-history"></i></a>
      <c:if test="${user.role == 'admin' || user.role == 'Division Leader' || user.role == 'Team Leader'}">
        <a href="approveLeave" title="Approve" style="color:#fff;"><i class="fas fa-check"></i></a>
                    </c:if>
      <a href="logout" title="Logout" style="color:#fff;"><i class="fas fa-sign-out-alt"></i></a>
    </div>
    <div class="spacer" style="flex:1;"></div>
    <div class="user-info" style="display:flex;align-items:center;gap:8px;">
      <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Settings"><i class="fas fa-cog"></i></button>
      <button style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="User Info"><i class="fas fa-user"></i></button>
      <span style="color:#888;margin:0 8px;">|</span>
      <span style="color:#f7c873;">${user.username}</span>
      <div class="avatar" style="width:40px;height:40px;border-radius:50%;background:#2e3a4d;display:flex;align-items:center;justify-content:center;font-size:20px;color:#f7c873;">${user.username.substring(0,1)}</div>
    </div>
  </div>
  <div class="submenu">
    <a href="dashboard" class="tab-btn active">Home</a>
    <a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
    <a href="leaveHistory" class="tab-btn">Leave History</a>
    <a href="approveLeave" class="nav-btn">Approve</a>
    <a href="profile" class="nav-btn">Profile</a>
  </div>
  <div class="main-content" style="display:flex;height:calc(100vh - 112px);padding:0;margin-left:0;">
    <div class="center-panel" style="flex:1 1 0;min-width:0;padding:32px 40px;display:flex;flex-direction:column;align-items:center;justify-content:center;background:rgba(24,31,42,0.95);">
      <div id="lichtrinh" class="tab-content">
        <div class="web-info-card" style="background:#222c3a;border-radius:10px;padding:32px 24px;width:400px;color:#fff;box-shadow:0 4px 24px rgba(0,0,0,0.2);margin:0 auto;text-align:center;">
          <h2 style="color:#f7c873;margin-bottom:18px;">Welcome to Leave Management System</h2>
          <p style="font-size:17px;line-height:1.6;">This web application helps you manage leave requests, approvals, and history for your organization.<br><br>Use the menu above to submit a leave request, view your leave history, approve requests (if you are a manager), and manage your profile.<br><br>For any questions, please contact your HR department.</p>
                </div>
            </div>
      <div id="lichsu" class="tab-content" style="display:none;">
        <div class="history-card" style="background:#222c3a;border-radius:10px;padding:24px 12px;width:100%;color:#fff;box-shadow:0 4px 24px rgba(0,0,0,0.2);margin:0 auto;">
          <h2 style="text-align:center;color:#f7c873;margin-bottom:18px;">Leave Request History</h2>
          <h3 style="color:#f7c873;">Personal History</h3>
          <div class="history-table-container" style="overflow-x:auto;">
            <table class="history-table" style="width:100%;background:#181f2a;color:#fff;border-radius:8px;">
                    <tr>
                <th>Request ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Created By</th>
                <th>Processed By</th>
                    </tr>
              <c:forEach var="request" items="${personalRequests}">
                                    <tr>
                  <td>${request.requestId}</td>
                  <td>${request.startDate}</td>
                  <td>${request.endDate}</td>
                  <td>${request.reason}</td>
                  <td>${request.status}</td>
                  <td>${request.createdByFullname}</td>
                  <td>${request.processedByFullname}</td>
                                    </tr>
                            </c:forEach>
            </table>
          </div>
          <c:if test="${not empty subordinateRequests}">
            <h3 style="color:#f7c873;">Subordinates' History</h3>
            <div class="history-table-container" style="overflow-x:auto;">
              <table class="history-table" style="width:100%;background:#181f2a;color:#fff;border-radius:8px;">
                <tr>
                  <th>Request ID</th>
                  <th>Username</th>
                  <th>Start Date</th>
                  <th>End Date</th>
                  <th>Reason</th>
                  <th>Status</th>
                  <th>Created By</th>
                  <th>Processed By</th>
                </tr>
                <c:forEach var="request" items="${subordinateRequests}">
                                    <tr>
                    <td>${request.requestId}</td>
                    <td>${request.user.username}</td>
                    <td>${request.startDate}</td>
                    <td>${request.endDate}</td>
                    <td>${request.reason}</td>
                    <td>${request.status}</td>
                    <td>${request.createdByFullname}</td>
                    <td>${request.processedByFullname}</td>
                                    </tr>
                            </c:forEach>
                </table>
            </div>
          </c:if>
        </div>
      </div>
    </div>
    <div class="right-panel" style="width:20%;background:#181f2a;padding:32px 16px;display:flex;flex-direction:column;align-items:center;">
      <div style="font-weight:bold; margin-bottom:10px; color:#f7c873;">DIVISION MEMBERS</div>
      <div class="division-list" style="width:100%;margin-top:16px;">
        <c:forEach var="member" items="${sameDivisionUsers}">
          <div class="friend online" style="display:flex;align-items:center;margin-bottom:12px;color:#fff;font-size:15px;gap:10px;">
            <span class="status-dot" style="width:10px;height:10px;border-radius:50%;background:#00ff99;margin-right:6px;"></span>
            ${member.fullname}
          </div>
        </c:forEach>
        </div>
    </div>
  </div>
  <div class="footer" style="position:fixed;bottom:0;left:0;width:100%;background:#181f2a;color:#ccc;font-size:13px;padding:6px 32px;border-top:1px solid #222c3a;z-index:10;">
  </div>
  <script>
    function showTab(tab, btn) {
      document.getElementById('lichtrinh').style.display = tab === 'lichtrinh' ? 'block' : 'none';
      document.getElementById('lichsu').style.display = tab === 'lichsu' ? 'block' : 'none';
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
    }
  </script>
</body>
</html>