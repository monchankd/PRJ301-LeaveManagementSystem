INSERT INTO Departments (DepartmentName) VALUES ('Phòng IT');
INSERT INTO Roles (RoleName) VALUES ('EMPLOYEE'), ('MANAGER');
INSERT INTO Users (Username, Password, FullName, DepartmentId, ManagerId)
VALUES 
    ('teo', '$2a$10$zXJ9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1z', 'Mr Tèo', 1, NULL),
    ('tit', '$2a$10$zXJ9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1z', 'Mr Tít', 1, NULL),
    ('employee1', '$2a$10$zXJ9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1zX8J8qX9qK1z', 'Mr F', 1, 2);
INSERT INTO UserRoles (UserId, RoleId) 
VALUES 
    (1, 1), -- Tèo là EMPLOYEE
    (2, 2), -- Tít là MANAGER
    (3, 1); -- Employee1 là EMPLOYEE
INSERT INTO LeaveStatus (StatusName) VALUES ('Inprogress'), ('Approved'), ('Rejected');
INSERT INTO LeaveRequests (UserId, Title, FromDate, ToDate, Reason, StatusId, ProcessedById, ProcessReason)
VALUES 
    (1, 'Xin nghỉ cưới', '2025-01-03', '2025-01-05', 'Lấy vợ', 1, NULL, NULL),
    (3, 'Xin nghỉ thử', '2025-01-05', '2025-01-05', 'Du lịch', 3, 2, 'Không đủ nhân sự');