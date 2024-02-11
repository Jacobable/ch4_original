//package com.fastcampus.ch4.controller;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.fastcampus.ch4.domain.Person;
//
//@Controller
//public class SimpleRestController2 {
//    @GetMapping("/ajax")
//    public String ajax() {
//        return "ajax";
//    }
//
//    @PostMapping("/send")
//    @ResponseBody
//    public Person test(@RequestBody Person p) {
//        System.out.println("p = " + p);
//        p.setName("ABC");
//        p.setAge(p.getAge() + 10);
//
//        return p;
//    }
//}