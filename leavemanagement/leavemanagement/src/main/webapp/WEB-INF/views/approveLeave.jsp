<%-- 
    Document   : approveLeave
    Created on : Jun 18, 2025, 4:05:05 PM
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
        <title>Approve Leave Requests</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #ffffff;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding-top: 2rem;
            }
            .approve-card {
                background: #fff;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 800px;
                text-align: center;
            }
            .approve-card h2 {
                margin-bottom: 1.5rem;
                color: #4a90e2;
                font-size: 1.75rem;
                font-weight: 700;
            }
            .approve-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }
            .approve-table th, .approve-table td {
                padding: 0.75rem;
                border: 1px solid #ddd;
                text-align: left;
                font-size: 0.95rem;
            }
            .approve-table th {
                background-color: #4a90e2;
                color: #fff;
            }
            .approve-table td form {
                display: inline;
            }
            .approve-table input[type="submit"] {
                padding: 0.25rem 0.5rem;
                margin: 0 0.25rem;
                background: #28a745;
                color: #fff;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                transition: background 0.3s;
            }
            .approve-table input[type="submit"].reject {
                background: #dc3545;
            }
            .approve-table input[type="submit"]:hover {
                opacity: 0.9;
            }
            .approve-card a {
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
            .approve-card a:hover {
                background: #357abd;
            }
        </style>
    </head>
    <body>
        <div class="approve-card">
            <h2>Approve Leave Requests</h2>
            <% 
                com.companyx.leavemanagement.models.User user = (com.companyx.leavemanagement.models.User) session.getAttribute("user");
                if (user == null || !user.getRole().equals("admin")) {
                    response.sendRedirect("dashboard");
                    return;
                }
            %>
            <table class="approve-table">
                <tr>
                    <th>Request ID</th>
                    <th>Username</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th>Role</th> 
                </tr>
                <c:forEach var="request" items="${leaveRequests}">
                    <tr>
                        <td>${request.requestId}</td>
                        <td>${request.user.username}</td>
                        <td>${request.startDate}</td>
                        <td>${request.endDate}</td>
                        <td>${request.reason}</td>
                        <td>${request.status}</td>
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
                        <td>
                            ${request.user.role} <!-- Hiển thị role hiện tại -->
                            <c:if test="${request.user.role == 'user'}">
                                <form action="updateRole" method="post"> <!-- Cần thêm endpoint -->
                                    <input type="hidden" name="userId" value="${request.user.userId}">
                                    <input type="hidden" name="newRole" value="admin">
                                    <input type="submit" value="Promote to Admin">
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <a href="dashboard">Back to Dashboard</a>
        </div>
    </body>
</html>
