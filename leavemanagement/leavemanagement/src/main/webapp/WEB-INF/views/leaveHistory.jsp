<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.companyx.leavemanagement.models.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Leave Request History</title>
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
            .history-card {
                background: #222c3a;
                border-radius: 10px;
                padding: 20px 12px 24px 12px;
                width: 100%;
                color: #fff;
                box-shadow: 0 4px 24px rgba(0,0,0,0.2);
                margin: 12px auto 0 auto;
            }
            .history-card h2 {
                text-align: center;
                color: #f7c873;
                margin-bottom: 18px;
            }
            .history-card h3 {
                color: #f7c873;
            }
            .history-table-container {
                overflow-x: auto;
            }
            .history-table {
                width: 100%;
                background: #181f2a;
                color: #fff;
                border-radius: 8px;
            }
            .history-table th, .history-table td {
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
            .history-table th {
                background: linear-gradient(90deg, #4a90e2, #357abd);
                color: #fff;
            }
            .history-table tr:hover td {
                background: #222c3a;
            }
            .history-table tr:hover td.status-Pending {
                color: #fff;
            }
            .history-table tr:hover td.status-Approved {
                color: #fff;
            }
            .history-table tr:hover td.status-Rejected {
                color: #fff;
            }
            .history-table td.status-Pending {
                background: #ffeb3b;
                color: #333;
                font-weight: 500;
            }
            .history-table td.status-Approved {
                background: #28a745;
                color: #fff;
                font-weight: 500;
            }
            .history-table td.status-Rejected {
                background: #dc3545;
                color: #fff;
                font-weight: 500;
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
            
            /* User profile button hover effect */
            .user-info button:hover {
                color: #f7c873 !important;
                transform: scale(1.1);
                transition: all 0.3s ease;
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
            /* Hide scrollbar but allow scrolling */
            html::-webkit-scrollbar, body::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
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
                        
                        // Populate modal data
                        document.getElementById('modal-start-date').textContent = row.querySelector('.start-date').textContent;
                        document.getElementById('modal-end-date').textContent = row.querySelector('.end-date').textContent;
                        document.getElementById('modal-request-id').textContent = row.getAttribute('data-request-id');
                        document.getElementById('modal-reason').textContent = row.getAttribute('data-reason') || 'No reason provided';
                        document.getElementById('modal-created-by').textContent = row.querySelector('.created-by').textContent;
                        document.getElementById('modal-processed-by').textContent = row.querySelector('.processed-by').textContent || 'Not processed yet';
                        
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
            <a href="leaveHistory" class="tab-btn active">Leave History</a>
            <c:if test="${user != null && (user.role == 'admin' || user.role == 'Division Leader' || user.role == 'Team Leader')}">
                <a href="approveLeave" class="nav-btn">Approve</a>
            </c:if>
            <c:if test="${user.role == 'Division Leader'}">
                <a href="agenda" class="nav-btn">Agenda</a>
            </c:if>
            <a href="profile" class="nav-btn">Profile</a>
        </div>
        <div class="main-content">
            <div class="center-panel">
                <div class="history-card">
                    <h2>Leave Request History</h2>
                    <h3>Personal History</h3>
                    <div class="history-table-container">
                        <table class="history-table">
                            <tr>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Created By</th>
                                <th>Processed By</th>
                                <th>Details</th>
                            </tr>
                            <c:forEach var="request" items="${personalRequests}">
                                <tr data-request-id="${request.requestId}" data-reason="${request.reason}">
                                    <td class="start-date">${request.startDate}</td>
                                    <td class="end-date">${request.endDate}</td>
                                    <td class="status status-${request.status}">${request.status}</td>
                                    <td class="created-by">${request.createdByFullname}</td>
                                    <td class="processed-by">${request.processedByFullname}</td>
                                    <td><button class="details-btn">Details</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                    <!-- Pagination for personal history -->
                    <c:if test="${personalTotalPages > 1}">
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="${personalTotalPages}">
                                <a href="leaveHistory?personalPage=${i}&subordinatePage=${subordinatePage}" class="page-btn${i == personalPage ? ' active' : ''}">${i}</a>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${not empty subordinateRequests}">
                        <h3>Subordinates' History</h3>
                        <div class="history-table-container">
                            <table class="history-table">
                                <tr>
                                    <th>Username</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Status</th>
                                    <th>Created By</th>
                                    <th>Processed By</th>
                                    <th>Details</th>
                                </tr>
                                <c:forEach var="request" items="${subordinateRequests}">
                                    <tr data-request-id="${request.requestId}" data-reason="${request.reason}">
                                        <td>${request.user.username}</td>
                                        <td class="start-date">${request.startDate}</td>
                                        <td class="end-date">${request.endDate}</td>
                                        <td class="status status-${request.status}">${request.status}</td>
                                        <td class="created-by">${request.createdByFullname}</td>
                                        <td class="processed-by">${request.processedByFullname}</td>
                                        <td><button class="details-btn">Details</button></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                        <!-- Pagination for subordinate history -->
                        <c:if test="${subordinateTotalPages > 1}">
                            <div class="pagination">
                                <c:forEach var="i" begin="1" end="${subordinateTotalPages}">
                                    <a href="leaveHistory?personalPage=${personalPage}&subordinatePage=${i}" class="page-btn${i == subordinatePage ? ' active' : ''}">${i}</a>
                                </c:forEach>
                            </div>
                        </c:if>
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
                        <div class="detail-item">
                            <div class="detail-label">
                                <i class="fas fa-user-check"></i>
                                Processed By
                            </div>
                            <div class="detail-value" id="modal-processed-by"></div>
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
</html>