<%-- 
    Document   : register
    Created on : Jun 18, 2025, 4:20:53 PM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow-x: hidden;
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
        .register-card {
            background: #222c3a;
            padding: 2rem 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.18);
            width: 100%;
            max-width: 420px;
            text-align: center;
            color: #fff;
        }
        .register-card h2 {
            margin-bottom: 1.5rem;
            color: #f7c873;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .register-card label {
            display: block;
            text-align: left;
            margin-bottom: 0.5rem;
            color: #f7c873;
            font-weight: 500;
        }
        .register-card input, .register-card select {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #444;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
            background: #181f2a;
            color: #fff;
        }
        .register-card input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background: #f7c873;
            color: #222c3a;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1.1rem;
            transition: background 0.3s;
        }
        .register-card input[type="submit"]:hover {
            background: #ffd36b;
        }
        .register-card .message {
            color: #28a745;
            margin-top: 1rem;
            font-size: 0.95rem;
        }
        .register-card .error {
            color: #dc3545;
            margin-top: 1rem;
            font-size: 0.95rem;
        }
        .register-card a {
            color: #f7c873;
            text-decoration: underline;
            font-size: 0.98rem;
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
      <button id="theme-toggle" style="background:none;border:none;color:#fff;cursor:pointer;font-size:18px;margin-right:2px;" title="Toggle light/dark"><i id="theme-toggle-icon" class="fas fa-moon"></i></button>
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
    <a href="dashboard" class="tab-btn">Home</a>
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
        <a href="register" class="nav-btn active">Register User</a>
    </c:if>
    <a href="profile" class="nav-btn">Profile</a>
  </div>
  <div class="main-content">
    <div class="center-panel">
      <div class="register-card">
        <h2>Register New User</h2>
        <form action="register" method="post">
          <label>Username:</label>
          <input type="text" name="username" required style="width:100%;margin-bottom:12px;">
          <label>Password:</label>
          <input type="password" name="password" required style="width:100%;margin-bottom:12px;">
          <label>Full Name:</label>
          <input type="text" name="fullname" required style="width:100%;margin-bottom:12px;">
          <label>Role:</label>
          <select name="role" required style="width:100%;margin-bottom:12px;">
            <option value="Team Member">Team Member</option>
            <option value="Team Leader">Team Leader</option>
            <option value="Division Leader">Division Leader</option>
            <option value="admin">Admin</option>
          </select>
          <label>Division:</label>
          <input type="text" name="division" style="width:100%;margin-bottom:12px;">
          <label>Manager ID:</label>
          <input type="text" name="managerId" style="width:100%;margin-bottom:16px;">
          <button type="submit">Register</button>
        </form>
      </div>
    </div>
    <div class="right-panel">
      <div style="font-weight:bold; margin-bottom:10px; color:#f7c873;">HƯỚNG DẪN</div>
      <div>Điền đầy đủ thông tin để tạo tài khoản mới cho nhân viên.</div>
    </div>
  </div>
  <div class="footer"></div>
  <!-- Modal denied quyền -->
  <div id="accessDeniedModal" class="modal" style="display:none;position:fixed;z-index:9999;left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.5);align-items:center;justify-content:center;">
    <div class="modal-content" style="background:#fff;color:#222c3a;padding:32px 40px;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,0.25);min-width:320px;text-align:center;animation:modalFadeIn 0.3s;">
      <h2 style="color:#f44336;margin-bottom:16px;"><i class="fas fa-ban"></i> Truy cập bị từ chối</h2>
      <p>Bạn không có quyền truy cập trang này.</p>
      <button onclick="closeDeniedModal()" style="margin-top:18px;padding:8px 24px;background:#f44336;color:#fff;border:none;border-radius:6px;font-size:16px;cursor:pointer;">Đóng</button>
    </div>
  </div>
  <!-- Change Password Modal (English, modern style) -->
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
  function closeDeniedModal() {
    document.getElementById('accessDeniedModal').style.display = 'none';
  }
  window.onload = function() {
    if ('${param.denied}' === 'true') {
      document.getElementById('accessDeniedModal').style.display = 'flex';
    }
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
  if (themeToggle) {
    themeToggle.addEventListener('click', function() {
      const isDark = !document.body.classList.contains('dark-mode');
      setTheme(isDark);
    });
    if (localStorage.getItem('darkMode') === '1') setTheme(true);
  }
  </script>
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
  <style>
  @keyframes modalFadeIn { from { opacity:0; transform:scale(0.95);} to { opacity:1; transform:scale(1);} }
  .modal { display:none; }
  .modal[style*="display: flex"] { display: flex !important; }
  #settings-dropdown div:hover { background: #34405a; }
  </style>
</body>
</html>