package org.example.controller;

import org.example.dao.UserRepository;
import org.example.model.Role;
import org.example.model.User;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.swing.*;
import javax.validation.Valid;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("profile")
    public String getProfile(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        model.addAttribute("username", userDetails.getUsername());
        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(@Valid User user,Model model,@RequestParam String passwordOld) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User userCurrent=userRepository.findByUsername(auth.getName());
        if (userService.rightPassword(userCurrent,passwordOld)){
            model.addAttribute("passwordError", "Passwords are different!");
            return "profile";
        }
        if (user.getPasswordRepeat() != null && !user.getPassword().equals(user.getPasswordRepeat())) {
            model.addAttribute("username", user.getUsername());
            model.addAttribute("passwordError", "Passwords are different!");
            return "profile";
        }
        userService.updateProfile(userCurrent, user.getPassword());
        return "redirect:/blog";
    }
}