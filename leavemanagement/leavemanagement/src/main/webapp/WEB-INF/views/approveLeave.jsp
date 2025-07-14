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
                max-width: 1100px;
                margin: 16px auto 0 auto;
                color: #fff;
                box-shadow: 0 4px 24px rgba(0,0,0,0.2);
            }
            .approve-card h2 {
                text-align: center;
                color: #f7c873;
                margin-bottom: 18px;
            }
            .approve-table-container {
                overflow-x: auto;
                width: 100%;
                max-width: 1100px;
                margin: 0 auto;
            }
            .approve-table {
                width: 100%;
                min-width: 700px;
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
            
            /* Enhanced Modal Styles */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(8px);
                justify-content: center;
                align-items: center;
                z-index: 1000;
                animation: fadeIn 0.3s ease-out;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            
            @keyframes slideIn {
                from { 
                    transform: translateY(-50px) scale(0.9);
                    opacity: 0;
                }
                to { 
                    transform: translateY(0) scale(1);
                    opacity: 1;
                }
            }
            
            .modal-content {
                background: linear-gradient(135deg, #2a3441 0%, #1e2634 100%);
                padding: 0;
                border-radius: 20px;
                width: 90%;
                max-width: 600px;
                text-align: left;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
                color: #fff;
                animation: slideIn 0.4s ease-out;
                border: 1px solid rgba(255, 255, 255, 0.1);
                overflow: hidden;
            }
            
            .modal-header {
                background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
                padding: 24px 30px 20px 30px;
                position: relative;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }
            
            .modal-header h3 {
                margin: 0;
                font-size: 24px;
                font-weight: 600;
                color: #fff;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            
            .modal-header h3 i {
                font-size: 20px;
                color: #f7c873;
            }
            
            .close-btn {
                position: absolute;
                top: 20px;
                right: 20px;
                background: rgba(255, 255, 255, 0.2);
                color: #fff;
                border: none;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
            }
            
            .close-btn:hover {
                background: rgba(220, 53, 69, 0.8);
                transform: scale(1.1);
            }
            
            .modal-body {
                padding: 30px;
            }
            
            .detail-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 24px;
            }
            
            .detail-item {
                background: rgba(255, 255, 255, 0.05);
                padding: 16px 20px;
                border-radius: 12px;
                border: 1px solid rgba(255, 255, 255, 0.1);
                transition: all 0.3s ease;
            }
            
            .detail-item:hover {
                background: rgba(255, 255, 255, 0.08);
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            }
            
            .detail-label {
                font-size: 12px;
                color: #f7c873;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 6px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .detail-value {
                font-size: 16px;
                color: #fff;
                font-weight: 500;
                word-break: break-word;
            }
            
            .detail-item.full-width {
                grid-column: 1 / -1;
            }
            
            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .status-badge.pending {
                background: linear-gradient(135deg, #ffeb3b, #ffc107);
                color: #333;
            }
            
            .status-badge.approved {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: #fff;
            }
            
            .status-badge.rejected {
                background: linear-gradient(135deg, #dc3545, #e74c3c);
                color: #fff;
            }
            
            .modal-footer {
                padding: 20px 30px 30px 30px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                justify-content: flex-end;
                gap: 12px;
            }
            
            .modal-btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
            }
            
            .modal-btn.primary {
                background: linear-gradient(135deg, #4a90e2, #357abd);
                color: #fff;
            }
            
            .modal-btn.primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(74, 144, 226, 0.4);
            }
            
            .modal-btn.secondary {
                background: rgba(255, 255, 255, 0.1);
                color: #fff;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .modal-btn.secondary:hover {
                background: rgba(255, 255, 255, 0.15);
                transform: translateY(-2px);
            }
            
            @media (max-width: 768px) {
                .detail-grid {
                    grid-template-columns: 1fr;
                }
                
                .modal-content {
                    width: 95%;
                    margin: 20px;
                }
                
                .modal-header, .modal-body, .modal-footer {
                    padding: 20px;
                }
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
            
            /* User profile button hover effect */
            .user-info button:hover {
                color: #f7c873 !important;
                transform: scale(1.1);
                transition: all 0.3s ease;
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
            .pagination {
                margin: 16px 0 0 0;
                text-align: center;
            }
            .page-btn {
                display: inline-block;
                margin: 0 4px;
                padding: 6px 14px;
                background: #222c3a;
                color: #f7c873;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                transition: background 0.2s, color 0.2s;
            }
            .page-btn.active, .page-btn:hover {
                background: #f7c873;
                color: #222c3a;
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
                        const status = row.querySelector('.status').textContent;
                        const username = row.querySelector('td:first-child').textContent;
                        
                        // Populate modal data
                        document.getElementById('modal-start-date').textContent = row.querySelector('.start-date').textContent;
                        document.getElementById('modal-end-date').textContent = row.querySelector('.end-date').textContent;
                        document.getElementById('modal-request-id').textContent = row.getAttribute('data-request-id');
                        document.getElementById('modal-reason').textContent = row.getAttribute('data-reason') || 'No reason provided';
                        document.getElementById('modal-username').textContent = username;
                        document.getElementById('modal-created-by').textContent = username; // In approve view, created by is the same as username
                        
                        // Set status badge with appropriate styling
                        const statusBadge = document.getElementById('modal-status-badge');
                        statusBadge.textContent = status;
                        statusBadge.className = 'status-badge';
                        
                        if (status === 'Pending') {
                            statusBadge.classList.add('pending');
                        } else if (status === 'Approved') {
                            statusBadge.classList.add('approved');
                        } else if (status === 'Rejected') {
                            statusBadge.classList.add('rejected');
                        }
                        
                        // Show modal with animation
                        modal.style.display = 'flex';
                        setTimeout(() => {
                            modal.querySelector('.modal-content').style.transform = 'translateY(0) scale(1)';
                        }, 10);
                    });
                });
                
                closeBtn.addEventListener('click', closeModal);
                
                window.addEventListener('click', function (event) {
                    if (event.target === modal) {
                        closeModal();
                    }
                });
                
                // Close modal with Escape key
                document.addEventListener('keydown', function(event) {
                    if (event.key === 'Escape' && modal.style.display === 'flex') {
                        closeModal();
                    }
                });
            });
            
            function closeModal() {
                const modal = document.getElementById('myModal');
                const modalContent = modal.querySelector('.modal-content');
                modalContent.style.transform = 'translateY(-50px) scale(0.9)';
                modalContent.style.opacity = '0';
                
                setTimeout(() => {
                    modal.style.display = 'none';
                    modalContent.style.transform = '';
                    modalContent.style.opacity = '';
                }, 300);
            }
            
            function printDetails() {
                const printWindow = window.open('', '_blank');
                const modalContent = document.querySelector('.modal-content').cloneNode(true);
                
                // Remove buttons from print version
                const footer = modalContent.querySelector('.modal-footer');
                if (footer) footer.remove();
                
                printWindow.document.write(`
                    <html>
                        <head>
                            <title>Leave Request Details</title>
                            <style>
                                body { font-family: Arial, sans-serif; margin: 20px; }
                                .modal-content { background: white; padding: 20px; border-radius: 10px; }
                                .modal-header { background: #4a90e2; color: white; padding: 15px; border-radius: 10px 10px 0 0; margin: -20px -20px 20px -20px; }
                                .detail-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
                                .detail-item { border: 1px solid #ddd; padding: 10px; border-radius: 5px; }
                                .detail-label { font-weight: bold; color: #666; font-size: 12px; text-transform: uppercase; }
                                .detail-value { margin-top: 5px; }
                                .status-badge { padding: 5px 10px; border-radius: 15px; font-weight: bold; }
                                .status-badge.pending { background: #ffeb3b; color: #333; }
                                .status-badge.approved { background: #28a745; color: white; }
                                .status-badge.rejected { background: #dc3545; color: white; }
                                @media print { body { margin: 0; } }
                            </style>
                        </head>
                        <body>
                            ${modalContent.outerHTML}
                        </body>
                    </html>
                `);
                printWindow.document.close();
                printWindow.print();
            }
        </script>
    </head>
    <body style="margin:0;">
        <div class="navbar">
            <div class="logo">L</div>
            <div class="icon-bar">
                <a href="dashboard" title="Dashboard"><i class="fas fa-tachometer-alt"></i></a>
                <a href="submitLeaveRequest" title="Submit Leave Request"><i class="fas fa-calendar"></i></a>
                <a href="leaveHistory" title="Leave History"><i class="fas fa-history"></i></a>
                <c:if test="${user.role == 'admin'}">
                    <a href="approveLeave" title="Approve"><i class="fas fa-check"></i></a>
                </c:if>
                <a href="logout" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
            </div>
            <div class="spacer"></div>
            <div class="user-info">
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
                <div class="avatar">${user.username.substring(0,1)}</div>
            </div>
        </div>
        <div class="submenu">
            <a href="dashboard" class="tab-btn">Home</a>
            <c:if test="${user.role != 'admin'}">
                <a href="submitLeaveRequest" class="tab-btn">Submit Leave Request</a>
                <a href="leaveHistory" class="tab-btn">Leave History</a>
            </c:if>
            <c:if test="${user.role == 'Division Leader' || user.role == 'Team Leader'}">
                <a href="approveLeave" class="nav-btn active">Approve</a>
            </c:if>
            <c:if test="${user.role == 'Division Leader'}">
                <a href="agenda" class="nav-btn">Agenda</a>
            </c:if>
            <c:if test="${user.role == 'admin'}">
                <a href="register" class="nav-btn">Register User</a>
            </c:if>
            <a href="profile" class="nav-btn">Profile</a>
        </div>
        <div class="main-content">
            <div class="center-panel">
                <div class="approve-card">
                    <h2>Approve Leave Requests</h2>
                    <form method="get" action="approveLeave" style="margin-bottom: 16px; text-align: right;">
                        <label for="pageSize" style="color:#f7c873; font-weight:500;">Records per page:</label>
                        <select name="pageSize" id="pageSize" onchange="this.form.submit()" style="margin-left:8px; padding:4px 10px; border-radius:6px; border:1px solid #222c3a; background:#181f2a; color:#f7c873;">
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                        </select>
                        <input type="hidden" name="page" value="${page}" />
                    </form>
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
                <!-- Pagination for approve leave -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination" style="margin: 16px 0 0 0; text-align: center;">
                        <c:if test="${page > 1}">
                            <a href="approveLeave?page=1&pageSize=${pageSize}" class="page-btn">First</a>
                            <a href="approveLeave?page=${page-1}&pageSize=${pageSize}" class="page-btn">Prev</a>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="approveLeave?page=${i}&pageSize=${pageSize}" class="page-btn${i == page ? ' active' : ''}">${i}</a>
                        </c:forEach>
                        <c:if test="${page < totalPages}">
                            <a href="approveLeave?page=${page+1}&pageSize=${pageSize}" class="page-btn">Next</a>
                            <a href="approveLeave?page=${totalPages}&pageSize=${pageSize}" class="page-btn">Last</a>
                        </c:if>
                    </div>
                </c:if>
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
        <div id="myModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3><i class="fas fa-file-alt"></i> Leave Request Details</h3>
                    <button class="close-btn"><i class="fas fa-times"></i></button>
                </div>
                <div class="modal-body">
                    <div class="detail-grid">
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-hashtag"></i>
                                Request ID
                            </div>
                            <div class="detail-value" id="modal-request-id"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-user"></i>
                                Username
                            </div>
                            <div class="detail-value" id="modal-username"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-calendar-check"></i>
                                Start Date
                            </div>
                            <div class="detail-value" id="modal-start-date"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-calendar-times"></i>
                                End Date
                            </div>
                            <div class="detail-value" id="modal-end-date"></div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-info-circle"></i>
                                Status
                            </div>
                            <div class="detail-value">
                                <span class="status-badge" id="modal-status-badge"></span>
                            </div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-user-plus"></i>
                                Created By
                            </div>
                            <div class="detail-value" id="modal-created-by"></div>
                        </div>
                        <div class="detail-item full-width">
                            <div class="detail-label">
                                <i class="fas fa-comment-alt"></i>
                                Reason
                            </div>
                            <div class="detail-value" id="modal-reason"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="modal-btn secondary" onclick="closeModal()">
                        <i class="fas fa-times"></i> Close
                    </button>
                    <button class="modal-btn primary" onclick="printDetails()">
                        <i class="fas fa-print"></i> Print
                    </button>
                </div>
            </div>
        </div>
        <!-- Modal thông báo không có quyền truy cập -->
        <div id="accessDeniedModal" class="modal" style="display:none;position:fixed;z-index:9999;left:0;top:0;width:100vw;height:100vh;background:rgba(0,0,0,0.5);align-items:center;justify-content:center;">
          <div class="modal-content" style="background:#fff;color:#222c3a;padding:32px 40px;border-radius:12px;box-shadow:0 8px 32px rgba(0,0,0,0.25);min-width:320px;text-align:center;animation:modalFadeIn 0.3s;">
            <h2 style="color:#f44336;margin-bottom:16px;"><i class="fas fa-ban"></i> Truy cập bị từ chối</h2>
            <p>Bạn không có quyền truy cập trang này.</p>
            <button onclick="closeDeniedModal()" style="margin-top:18px;padding:8px 24px;background:#f44336;color:#fff;border:none;border-radius:6px;font-size:16px;cursor:pointer;">Đóng</button>
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
    if (settingsDropdown && settingsDropdown.style.display === 'block' && !settingsBtn.contains(e.target) && !settingsDropdown.contains(e.target)) {
      settingsDropdown.style.display = 'none';
    }
  });
  if(settingsBtn && openChangePassword && settingsDropdown) {
    settingsBtn.onclick = function(e) {
      e.stopPropagation();
      settingsDropdown.style.display = settingsDropdown.style.display === 'block' ? 'none' : 'block';
    };
    openChangePassword.onclick = function(e) {
      e.stopPropagation();
      settingsDropdown.style.display = 'none';
      document.getElementById('changePasswordModal').style.display = 'flex';
    };
  }
  // Modal logic
  const changePasswordForm = document.getElementById('changePasswordForm');
  const changePasswordError = document.getElementById('changePasswordError');
  if(changePasswordForm) {
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
  }
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
