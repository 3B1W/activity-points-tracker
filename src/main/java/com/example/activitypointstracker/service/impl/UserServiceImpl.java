package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.UserRegistrationDto;
import com.example.activitypointstracker.entity.Role;
import com.example.activitypointstracker.entity.User;
import com.example.activitypointstracker.repository.UserRepository;
import com.example.activitypointstracker.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Override
    public User save(UserRegistrationDto userDto) {
        User user = new User(userDto.getFname(),userDto.getLname(),userDto.getEmail(),userDto.getPassword(), Arrays.asList(new Role("ROLE_USER")));
        return userRepository.save(user);
    }
}

