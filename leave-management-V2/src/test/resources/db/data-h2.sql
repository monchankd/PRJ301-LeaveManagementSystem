INSERT INTO Departments (DepartmentId, DepartmentName) VALUES (1, 'IT Department');
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'EMPLOYEE'), (2, 'MANAGER');
INSERT INTO Users (UserId, Username, Password, FullName, DepartmentId, ManagerId)
VALUES 
    (1, 'teo', '$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', 'Mr Teo', 1, NULL),
    (2, 'tit', '$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', 'Mr Tit', 1, NULL),
    (3, 'employee1', '$2a$10$XURPShQNCsLjp1ESc2laoObo9QZDhz51hM6E9nS.oZ/lLXXWVKLyq', 'Mr F', 1, 2);
INSERT INTO UserRoles (UserId, RoleId)
VALUES 
    (1, 1), -- Teo is EMPLOYEE
    (2, 2), -- Tit is MANAGER
    (3, 1); -- Employee1 is EMPLOYEE
INSERT INTO LeaveStatus (StatusId, StatusName) VALUES 
    (1, 'Inprogress'), 
    (2, 'Approved'), 
    (3, 'Rejected');
INSERT INTO LeaveRequests (RequestId, UserId, Title, FromDate, ToDate, Reason, StatusId, ProcessedById, ProcessReason)
VALUES 
    (1, 1, 'Wedding Leave', '2025-01-03', '2025-01-05', 'Getting married', 1, NULL, NULL),
    (2, 3, 'Trial Leave', '2025-01-05', '2025-01-05', 'Travel', 3, 2, 'Insufficient staff');