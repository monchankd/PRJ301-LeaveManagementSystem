package main.java.com.companyx.leavemanagement.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/login", "/resources/**").permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .defaultSuccessUrl("/home", true)
                .permitAll()
            )
            .logout(logout -> logout.permitAll());
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            // Tạm thời sử dụng dữ liệu mẫu, sau này lấy từ DB
            if ("teo".equals(username)) {
                return org.springframework.security.core.userdetails.User
                    .withUsername("teo")
                    .password(passwordEncoder().encode("password123"))
                    .roles("EMPLOYEE")
                    .build();
            } else if ("tit".equals(username)) {
                return org.springframework.security.core.userdetails.User
                    .withUsername("tit")
                    .password(passwordEncoder().encode("password123"))
                    .roles("MANAGER")
                    .build();
            }
            throw new UsernameNotFoundException("User not found");
        };
    }
}