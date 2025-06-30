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
                height: 100%;
                overflow-x: hidden;
                background: linear-gradient(135deg, #4a90e2, #50e3c2);
                animation: gradientFlow 10s ease infinite;
            }
            @keyframes gradientFlow {
                0% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
                100% {
                    background-position: 0% 50%;
                }
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
                background: linear-gradient(180deg, #4a90e2, #357abd);
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
                from {
                    opacity: 0;
                    transform: translateX(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
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
                margin-left: 250px;
                padding: 30px;
                transition: all 0.3s ease;
                flex-grow: 1;
                overflow-x: hidden;
                box-sizing: border-box;
                position: relative;
            }
            .main-content.collapsed {
                margin-left: 70px;
            }
            .history-card {
                background: rgba(255, 255, 255, 0.9);
                padding: 2.5rem;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: none;
                text-align: center;
            }
            .history-card h2, .history-card h3 {
                margin-bottom: 1.5rem;
                color: #4a90e2;
                font-size: 2rem;
                font-weight: 700;
                text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
                animation: fadeIn 1s ease-in;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            .history-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                overflow-x: auto;
                table-layout: fixed;
                background: #fff;
                border-radius: 10px;
                overflow: hidden;
            }
            .history-table th, .history-table td {
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
            .history-table th {
                background: linear-gradient(90deg, #4a90e2, #357abd);
                color: #fff;
                width: auto;
            }
            .history-table tr:hover td {
                background: #f0f8ff;
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
                animation: pulse 2s infinite;
            }
            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }
            .details-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 5px 15px rgba(74, 144, 226, 0.5);
            }
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }
            .modal-content {
                background: #fff;
                padding: 2rem;
                border-radius: 15px;
                width: 90%;
                max-width: 550px;
                text-align: left;
                animation: slideDown 0.5s ease-out;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            }
            @keyframes slideDown {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            .modal-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }
            .modal-table th, .modal-table td {
                padding: 0.6rem;
                border: 1px solid #eee;
                text-align: left;
                font-size: 1rem;
            }
            .modal-table th {
                background: #f9f9f9;
                color: #4a90e2;
            }
            .close-btn {
                background: #dc3545;
                color: #fff;
                border: none;
                padding: 0.3rem 0.7rem;
                border-radius: 20px;
                cursor: pointer;
                float: right;
                transition: transform 0.3s, background 0.3s;
            }
            .close-btn:hover {
                transform: scale(1.05);
                background: #c82333;
            }
            .history-card a {
                display: inline-block;
                margin-top: 1.5rem;
                padding: 0.8rem 1.8rem;
                background: linear-gradient(45deg, #4a90e2, #9013fe);
                color: #fff;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 500;
                transition: transform 0.3s, background 0.3s;
                animation: bounceIn 1s ease-out;
            }
            @keyframes bounceIn {
                from {
                    transform: scale(0.8);
                    opacity: 0;
                }
                to {
                    transform: scale(1);
                    opacity: 1;
                }
            }
            .history-card a:hover {
                transform: scale(1.05);
                background: #357abd;
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
                .history-table {
                    width: 100vw;
                    margin-left: -15px;
                }
                .modal-content {
                    width: 95%;
                    padding: 1.5rem;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const sidebar = document.querySelector('#sidebar');
                const mainContent = document.querySelector('.main-content');

                if (sidebar) {
                    sidebar.addEventListener('click', function (e) {
                        const toggleBtn = e.target.closest('.toggle-btn');
                        if (toggleBtn) {
                            sidebar.classList.toggle('collapsed');
                            mainContent.classList.toggle('collapsed');
                        }
                    });
                }

                const detailsButtons = document.querySelectorAll('.details-btn');
                const modal = document.getElementById('myModal');
                const closeBtn = document.querySelector('.close-btn');

                // Ensure personalRequests and subordinateRequests are JSON-encoded
                const personalRequests = ${personalRequestsJson != null ? personalRequestsJson : '[]'};
                const subordinateRequests = ${subordinateRequestsJson != null ? subordinateRequestsJson : '[]'};

                detailsButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const requestId = this.getAttribute('data-id');
                        const request = [...personalRequests, ...subordinateRequests].find(r => r.requestId === parseInt(requestId));
                        if (request) {
                            document.getElementById('modal-start-date').textContent = request.startDate || '-';
                            document.getElementById('modal-end-date').textContent = request.endDate || '-';
                            document.getElementById('modal-reason').textContent = request.reason || '-';
                            document.getElementById('modal-status').textContent = request.status || '-';
                            document.getElementById('modal-created-by').textContent = request.createdByFullname || '-';
                            document.getElementById('modal-processed-by').textContent = request.processedByFullname || '-';
                            modal.style.display = 'flex';
                        }
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
    <body>
        <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
        <div class="main-content">
            <div class="history-card">
                <h2>Leave Request History</h2>
                <% 
                    com.companyx.leavemanagement.models.User user = (com.companyx.leavemanagement.models.User) session.getAttribute("user");
                    if (user == null) {
                        response.sendRedirect("login");
                        return;
                    }
                %>
                <!-- Bảng cho lịch sử bản thân -->
                <h3>Personal History</h3>
                <div class="history-table-container">
                    <table class="history-table">
                        <tr>
                            <th>Request ID</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Created By</th>
                            <th>Processed By</th>
                            <th>Details</th>
                        </tr>
                        <c:forEach var="request" items="${personalRequests}">
                            <tr>
                                <td>${request.requestId}</td>
                                <td>${request.startDate}</td>
                                <td>${request.endDate}</td>
                                <td>${request.reason}</td>
                                <td class="status-${request.status}">${request.status}</td>
                                <td>${request.createdByFullname}</td>
                                <td>${request.processedByFullname}</td>
                                <td><button class="details-btn" data-id="${request.requestId}">Details</button></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <!-- Bảng cho lịch sử cấp dưới -->
                <c:if test="${not empty subordinateRequests}">
                    <h3>Subordinates' History</h3>
                    <div class="history-table-container">
                        <table class="history-table">
                            <tr>
                                <th>Request ID</th>
                                <th>Username</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Created By</th>
                                <th>Processed By</th>
                                <th>Details</th>
                            </tr>
                            <c:forEach var="request" items="${subordinateRequests}">
                                <tr>
                                    <td>${request.requestId}</td>
                                    <td>${request.user.username}</td>
                                    <td>${request.startDate}</td>
                                    <td>${request.endDate}</td>
                                    <td>${request.reason}</td>
                                    <td class="status-${request.status}">${request.status}</td>
                                    <td>${request.createdByFullname}</td>
                                    <td>${request.processedByFullname}</td>
                                    <td><button class="details-btn" data-id="${request.requestId}">Details</button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>
                <a href="dashboard">Back to Dashboard</a>
            </div>
        </div>

        <div id="myModal" class="modal">
            <div class="modal-content">
                <button class="close-btn">Close</button>
                <h3>Leave Request Details</h3>
                <table class="modal-table">
                    <tr><th>Start Date</th><td id="modal-start-date"></td></tr>
                    <tr><th>End Date</th><td id="modal-end-date"></td></tr>
                    <tr><th>Reason</th><td id="modal-reason"></td></tr>
                    <tr><th>Status</th><td id="modal-status"></td></tr>
                    <tr><th>Created By</th><td id="modal-created-by"></td></tr>
                    <tr><th>Processed By</th><td id="modal-processed-by"></td></tr>
                </table>
            </div>
        </div>
    </body>
</html>