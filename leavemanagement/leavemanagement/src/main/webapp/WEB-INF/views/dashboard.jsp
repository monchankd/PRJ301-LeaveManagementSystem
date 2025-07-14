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
        
        /* User profile button hover effect */
        .user-info button:hover {
            color: #f7c873 !important;
            transform: scale(1.1);
            transition: all 0.3s ease;
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
      <button id="theme-toggle" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Chuyển đổi sáng/tối"><i id="theme-toggle-icon" class="fas fa-moon"></i></button>
      <button id="settings-btn" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;position:relative;" title="Settings"><i class="fas fa-cog"></i></button>
      <div id="settings-dropdown" style="display:none;position:absolute;top:36px;right:0;z-index:10001;background:#222c3a;border-radius:8px;box-shadow:0 4px 16px rgba(0,0,0,0.18);min-width:180px;">
        <div id="openChangePassword" style="padding:12px 20px;color:#fff;cursor:pointer;font-size:15px;border-radius:8px 8px 0 0;transition:background 0.2s;">
          <i class="fas fa-key" style="margin-right:8px;"></i> Change Password
        </div>
      </div>
      <button onclick="window.location.href='profile'" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="User Profile"><i class="fas fa-user"></i></button>
      <span style="color:#888;margin:0 8px;">|</span>
      <span style="color:#f7c873;">${user.username}</span>
      <div class="avatar" style="width:40px;height:40px;border-radius:50%;background:#2e3a4d;display:flex;align-items:center;justify-content:center;font-size:20px;color:#f7c873;">${user.username.substring(0,1)}</div>
    </div>
  </div>
  <div class="submenu">
    <a href="dashboard" class="tab-btn active">Home</a>
    <c:if test="${user.role != 'admin'}">
        <a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
        <a href="leaveHistory" class="tab-btn">Leave History</a>
    </c:if>
    <c:if test="${user.role == 'Division Leader' || user.role == 'Team Leader'}">
        <a href="approveLeave" class="nav-btn">Approve</a>
    </c:if>
    <c:if test="${user.role == 'Division Leader'}">
        <a href="agenda" class="nav-btn">Agenda</a>
    </c:if>
    <c:if test="${user.role == 'admin'}">
        <a href="register" class="nav-btn">Register User</a>
    </c:if>
    <a href="profile" class="nav-btn">Profile</a>
  </div>
  <div class="main-content" style="display:flex;height:calc(100vh - 112px);padding:0;margin-left:0;">
    <div class="center-panel" style="flex:1 1 0;min-width:0;padding:32px 40px;display:flex;flex-direction:column;align-items:center;justify-content:center;background:rgba(24,31,42,0.95);">
      <!-- Thông báo đổi mật khẩu -->
      <c:if test="${not empty changePasswordSuccess}">
        <div style="background:#4caf50;color:#fff;padding:12px 24px;border-radius:8px;margin-bottom:18px;">${changePasswordSuccess}</div>
      </c:if>
      <c:if test="${not empty changePasswordError}">
        <div style="background:#f44336;color:#fff;padding:12px 24px;border-radius:8px;margin-bottom:18px;">${changePasswordError}</div>
      </c:if>
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
          <c:if test="${member.role != 'admin'}">
            <div class="friend online" style="display:flex;align-items:center;margin-bottom:12px;color:#fff;font-size:15px;gap:10px;">
              <span class="status-dot" style="width:10px;height:10px;border-radius:50%;background:#00ff99;margin-right:6px;"></span>
              ${member.fullname}
            </div>
          </c:if>
        </c:forEach>
        </div>
    </div>
  </div>
  <div class="footer" style="position:fixed;bottom:0;left:0;width:100%;background:#181f2a;color:#ccc;font-size:13px;padding:6px 32px;border-top:1px solid #222c3a;z-index:10;">
  </div>
  
  <!-- Modal Đổi Mật Khẩu -->
  <div id="changePasswordModal" class="modal" style="display:none;position:fixed;z-index:10000;left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.5);align-items:center;justify-content:center;">
    <div class="modal-content" style="background:#fff;color:#222c3a;padding:36px 36px 28px 36px;border-radius:18px;box-shadow:0 8px 32px rgba(0,0,0,0.25);min-width:340px;max-width:95vw;text-align:center;animation:modalFadeIn 0.3s;position:relative;">
      <button onclick="closeChangePasswordModal()" style="position:absolute;top:16px;right:16px;background:none;border:none;font-size:22px;color:#888;cursor:pointer;"><i class="fas fa-times"></i></button>
      <h2 style="color:#4a90e2;margin-bottom:18px;font-weight:700;font-size:1.6em;"><i class="fas fa-key"></i> Change Password</h2>
      <form id="changePasswordForm" method="post" action="changePassword" style="display:flex;flex-direction:column;gap:18px;align-items:stretch;">
        <div style="text-align:left;">
          <label for="oldPassword" style="font-weight:500;">Current Password</label><br>
          <input type="password" id="oldPassword" name="oldPassword" required style="width:100%;padding:10px 12px;margin-top:6px;border-radius:8px;border:1.5px solid #d1d5db;font-size:15px;background:#f7f8fa;">
        </div>
        <div style="text-align:left;">
          <label for="newPassword" style="font-weight:500;">New Password</label><br>
          <input type="password" id="newPassword" name="newPassword" required style="width:100%;padding:10px 12px;margin-top:6px;border-radius:8px;border:1.5px solid #d1d5db;font-size:15px;background:#f7f8fa;">
        </div>
        <div style="text-align:left;">
          <label for="confirmPassword" style="font-weight:500;">Confirm New Password</label><br>
          <input type="password" id="confirmPassword" name="confirmPassword" required style="width:100%;padding:10px 12px;margin-top:6px;border-radius:8px;border:1.5px solid #d1d5db;font-size:15px;background:#f7f8fa;">
        </div>
        <div id="changePasswordError" style="color:#f44336;margin-bottom:0;display:none;text-align:left;"></div>
        <button type="submit" style="padding:12px 0;background:linear-gradient(90deg,#4a90e2 60%,#f7c873 100%);color:#fff;border:none;border-radius:8px;font-size:16px;cursor:pointer;font-weight:600;box-shadow:0 2px 8px 0 rgba(74,144,226,0.08);margin-top:8px;">Change Password</button>
      </form>
    </div>
  </div>
  
  <script>
    function closeChangePasswordModal() {
      var changePasswordModal = document.getElementById('changePasswordModal');
      var changePasswordForm = document.getElementById('changePasswordForm');
      var changePasswordError = document.getElementById('changePasswordError');
      changePasswordModal.style.display = 'none';
      if (changePasswordForm) changePasswordForm.reset();
      if (changePasswordError) changePasswordError.style.display = 'none';
    }
    document.addEventListener('DOMContentLoaded', function() {
      // Dropdown logic for settings
      const settingsBtn = document.getElementById('settings-btn');
      const settingsDropdown = document.getElementById('settings-dropdown');
      const openChangePassword = document.getElementById('openChangePassword');
      document.body.addEventListener('click', function(e) {
        if (settingsDropdown.style.display === 'block' && !settingsBtn.contains(e.target) && !settingsDropdown.contains(e.target)) {
          settingsDropdown.style.display = 'none';
        }
      });
      settingsBtn.onclick = function(e) {
        e.stopPropagation();
        settingsDropdown.style.display = settingsDropdown.style.display === 'block' ? 'none' : 'block';
      };
      openChangePassword.onclick = function(e) {
        e.stopPropagation();
        settingsDropdown.style.display = 'none';
        document.getElementById('changePasswordModal').style.display = 'flex';
      };
      // Modal logic
      const changePasswordForm = document.getElementById('changePasswordForm');
      const changePasswordError = document.getElementById('changePasswordError');
      changePasswordForm.onsubmit = function(e) {
        var newPass = document.getElementById('newPassword').value;
        var confirmPass = document.getElementById('confirmPassword').value;
        if (newPass !== confirmPass) {
          changePasswordError.innerText = 'Password confirmation does not match!';
          changePasswordError.style.display = 'block';
          e.preventDefault();
          return false;
        }
        changePasswordError.style.display = 'none';
        return true;
      };
    });
  </script>
  <script>
    function showTab(tab, btn) {
      document.getElementById('lichtrinh').style.display = tab === 'lichtrinh' ? 'block' : 'none';
      document.getElementById('lichsu').style.display = tab === 'lichsu' ? 'block' : 'none';
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
    }
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
<!-- Modal thông báo không có quyền truy cập -->
<div id="accessDeniedModal" class="modal" style="display:none;position:fixed;z-index:9999;left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.5);align-items:center;justify-content:center;">
  <div class="modal-content" style="background:#fff;color:#222c3a;padding:32px 40px;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,0.25);min-width:320px;text-align:center;animation:modalFadeIn 0.3s;">
    <h2 style="color:#f44336;margin-bottom:16px;"><i class="fas fa-ban"></i> Truy cập bị từ chối</h2>
    <p>Bạn không có quyền truy cập trang này.</p>
    <button onclick="closeDeniedModal()" style="margin-top:18px;padding:8px 24px;background:#f44336;color:#fff;border:none;border-radius:6px;font-size:16px;cursor:pointer;">Đóng</button>
  </div>
</div>
<script>
function closeDeniedModal() {
  document.getElementById('accessDeniedModal').style.display = 'none';
}
window.onload = function() {
  if ('${param.denied}' === 'true') {
    document.getElementById('accessDeniedModal').style.display = 'flex';
  }
}
</script>
<style>
@keyframes modalFadeIn { from { opacity:0; transform:scale(0.95);} to { opacity:1; transform:scale(1);} }
.modal { display:none; }
.modal[style*="display: flex"] { display: flex !important; }
#settings-dropdown div:hover { background: #34405a; }
</style>
</body>
</html>