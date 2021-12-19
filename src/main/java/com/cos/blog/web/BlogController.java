package com.cos.blog.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BlogController {
    
    @GetMapping("/")
    public String home(){
        return "<h1>Home</h1>";
    }
}
