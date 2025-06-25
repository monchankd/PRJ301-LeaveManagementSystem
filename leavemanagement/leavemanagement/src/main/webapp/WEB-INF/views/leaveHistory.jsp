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
            overflow-x: hidden; /* Prevent horizontal overflow at root level */
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .sidebar {
            width: 250px;
            background-color: #4a90e2;
            color: #fff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            transition: all 0.3s;
            z-index: 100;
            overflow-y: auto; /* Allow vertical scrolling if content overflows */
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
        }
        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .sidebar .nav-menu li {
            padding: 15px 20px;
        }
        .sidebar .nav-menu li a {
            color: #fff;
            text-decoration: none;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        .sidebar .nav-menu li a i {
            margin-right: 10px;
        }
        .sidebar .nav-menu li a:hover {
            background-color: #357abd;
            border-radius: 5px;
        }
        .sidebar.collapsed .nav-menu li a span {
            display: none;
        }
        .sidebar.collapsed .nav-menu li a i {
            margin-right: 0;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s;
            flex-grow: 1;
            overflow-x: hidden; /* Prevent horizontal overflow in main content */
            box-sizing: border-box; /* Include padding in width calculation */
        }
        .main-content.collapsed {
            margin-left: 70px;
        }
        .history-card {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%; /* Stretch to full width of main-content */
            max-width: none; /* Remove max-width constraint */
            text-align: center;
            box-sizing: border-box; /* Include padding in width */
        }
        .history-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .history-table {
            width: 100%; /* Ensure table takes full width of history-card */
            border-collapse: collapse;
            margin-top: 1rem;
            overflow-x: auto; /* Allow horizontal scroll within table if needed */
            table-layout: fixed; /* Distribute columns evenly */
        }
        .history-table th, .history-table td {
            padding: 0.75rem;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 0.95rem;
            white-space: nowrap;
            overflow: hidden; /* Prevent text overflow */
            text-overflow: ellipsis; /* Add ellipsis for long text */
            box-sizing: border-box; /* Include padding in cell width */
        }
        .history-table th {
            background-color: #4a90e2;
            color: #fff;
            width: auto; /* Allow dynamic width based on content */
        }
        .history-table td.status-Pending {
            background-color: #ffeb3b; /* Yellow for Pending */
            color: #333;
        }
        .history-table td.status-Approved {
            background-color: #28a745; /* Green for Approved */
            color: #fff;
        }
        .history-table td.status-Rejected {
            background-color: #dc3545; /* Red for Rejected */
            color: #fff;
        }
        .history-card a {
            display: inline-block;
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            background: #4a90e2;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s;
        }
        .history-card a:hover {
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
            }
            .main-content.collapsed {
                margin-left: 0;
            }
            .history-table {
                width: 100vw; /* Use viewport width on mobile */
                margin-left: -20px; /* Adjust for padding */
            }
        }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const sidebar = document.querySelector('.sidebar');
                const mainContent = document.querySelector('.main-content');
                const toggleBtn = document.querySelector('.toggle-btn');

                toggleBtn.addEventListener('click', function () {
                    sidebar.classList.toggle('collapsed');
                    mainContent.classList.toggle('collapsed');
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
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </c:if>
                <a href="dashboard">Back to Dashboard</a>
            </div>
        </div>
    </body>
</html>