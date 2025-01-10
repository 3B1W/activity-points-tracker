package com.example.activitypointstracker.controller;

import com.example.activitypointstracker.dto.UserRegistrationDto;
import com.example.activitypointstracker.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@RequestMapping("/registration")
public class UserRegistrationController {
    private UserService userService;

    @ModelAttribute("user")
    public UserRegistrationDto userRegistrationDto(){
        return new UserRegistrationDto();
    }

    @PostMapping
    public String RegisterUserAccount(@ModelAttribute("user")UserRegistrationDto userRegistrationDto){
        userService.save(userRegistrationDto);
        return "redirect/registration?success";
    }
}
