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
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
        }
        .history-card {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px;
            text-align: center;
        }
        .history-card h2 {
            margin-bottom: 1.5rem;
            color: #4a90e2;
            font-size: 1.75rem;
            font-weight: 700;
        }
        .history-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            overflow-x: auto;
        }
        .history-table th, .history-table td {
            padding: 0.75rem;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 0.95rem;
            white-space: nowrap;
        }
        .history-table th {
            background-color: #4a90e2;
            color: #fff;
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
    </style>
</head>
<body>
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
</body>
</html>