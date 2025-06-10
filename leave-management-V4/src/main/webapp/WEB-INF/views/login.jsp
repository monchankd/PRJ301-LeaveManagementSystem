<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://jakarta.apache.org/tags/c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Đăng nhập</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    <form action="/login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Tên đăng nhập</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
    </div>
        <button type="submit" class="btn btn-primary">Đăng nhập</button>
    </form>
</div>
</body>
</html>