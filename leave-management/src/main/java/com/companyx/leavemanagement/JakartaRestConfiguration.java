package com.companyx.leavemanagement;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

@ApplicationPath("/api")
public class JakartaRestConfiguration extends Application {
    // Cấu hình mặc định cho JAX-RS, có thể mở rộng bằng cách ghi đè các phương thức
}