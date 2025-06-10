INSERT INTO Departments (DepartmentId, DepartmentName) VALUES (1, N'IT Department');
INSERT INTO Roles (RoleId, RoleName) VALUES (1, N'EMPLOYEE'), (2, N'MANAGER');
INSERT INTO Users (UserId, Username, Password, FullName, DepartmentId, ManagerId)
VALUES 
    (1, N'teo', N'$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', N'Mr Teo', 1, NULL),
    (2, N'tit', N'$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', N'Mr Tit', 1, NULL),
    (3, N'employee1', N'$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', N'Mr F', 1, 2);
INSERT INTO UserRoles (UserId, RoleId)
VALUES 
    (1, 1), -- Teo is EMPLOYEE
    (2, 2), -- Tit is MANAGER
    (3, 1); -- Employee1 is EMPLOYEE
INSERT INTO LeaveStatus (StatusId, StatusName) VALUES 
    (1, N'Inprogress'), 
    (2, N'Approved'), 
    (3, N'Rejected');
INSERT INTO LeaveRequests (RequestId, UserId, Title, FromDate, ToDate, Reason, StatusId, ProcessedById, ProcessReason)
VALUES 
    (1, 1, N'Wedding Leave', '2025-01-03', '2025-01-05', N'Getting married', 1, NULL, NULL),
    (2, 3, N'Trial Leave', '2025-01-05', '2025-01-05', N'Travel', 3, 2, N'Insufficient staff');