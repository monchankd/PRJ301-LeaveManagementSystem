package com.companyx.leavemanagement.config;
import com.companyx.leavemanagement.entity.Department;
import com.companyx.leavemanagement.entity.User;
import com.companyx.leavemanagement.repository.DepartmentRepository;
import com.companyx.leavemanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Override
    public void run(String... args) throws Exception {
        Department it = new Department();
        it.setName("IT");
        departmentRepository.save(it);

        User manager = new User();
        manager.setUsername("manager");
        manager.setPassword("password"); // In production, use password encoding
        manager.setFullName("Mr B");
        manager.setDepartment(it);
        userRepository.save(manager);

        User employee = new User();
        employee.setUsername("employee");
        employee.setPassword("password");
        employee.setFullName("Mr Tèo");
        employee.setDepartment(it);
        employee.setManager(manager);
        userRepository.save(employee);
    }
}