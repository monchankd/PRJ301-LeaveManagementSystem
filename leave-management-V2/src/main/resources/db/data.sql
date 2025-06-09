
INSERT INTO Departments (DepartmentName) VALUES ('Phòng IT');

INSERT INTO Roles (RoleName) VALUES ('Nhân viên'), ('Trưởng phòng');

INSERT INTO Users (Username, Password, FullName, DepartmentId, ManagerId)
VALUES 
    ('teo', 'password123', 'Mr Tèo', 1, NULL),
    ('tit', 'password123', 'Mr Tít', 1, NULL),
    ('employee1', 'password123', 'Mr F', 1, 2);

INSERT INTO UserRoles (UserId, RoleId) 
VALUES 
    (1, 1), -- Tèo là Nhân viên
    (2, 2), -- Tít là Trưởng phòng
    (3, 1); -- Employee1 là Nhân viên

INSERT INTO LeaveStatus (StatusName) VALUES ('Inprogress'), ('Approved'), ('Rejected');

INSERT INTO LeaveRequests (UserId, Title, FromDate, ToDate, Reason, StatusId, ProcessedById, ProcessReason)
VALUES 
    (1, 'Xin nghỉ cưới', '2025-01-01', '2025-01-03', 'Lấy vợ', 1, NULL, NULL),
    (3, 'Xin nghỉ đi chơi', '2025-01-01', '2025-01-05', 'Du lịch', 3, 2, 'Không đủ nhân sự');