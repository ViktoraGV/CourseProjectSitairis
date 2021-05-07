package org.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@SpringBootApplication
public class ApplicationLauncher {
    public static void main(String[] arqs){
        SpringApplication.run(ApplicationLauncher.class,arqs);
    }
}
