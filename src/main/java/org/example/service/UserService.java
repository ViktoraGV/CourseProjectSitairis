package org.example.service;

import org.example.dao.UserRepository;
import org.example.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.example.model.User;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return (UserDetails) userRepository.findByUsername(username);
    }

    public boolean addUser(User user) {
        User UserFromDb = userRepository.findByUsername(user.getUsername());
        if (UserFromDb != null) {
            return false;
        }
        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        sendMessage(user);
        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Activate your user: http://localhost:8080/activate/%s",
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public Boolean rightPassword(User user, String password) {
        if (!StringUtils.isEmpty(password)) {
            if (user.getPassword()==passwordEncoder.encode(password)){
                return true;
            }
        }
        return false;
    }
    public void updateProfile(User user, String password) {
        if (!StringUtils.isEmpty(password)) {
            user.setPassword(passwordEncoder.encode(password));
            user.setPasswordRepeat(passwordEncoder.encode(password));
        }
        userRepository.save(user);
    }
}
