package com.example.SpringHelloWorld;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloService {

    @RequestMapping("/")
    public String index() {
        return ("HELLO WORLD FROM HRS GROUP");
    }

}
