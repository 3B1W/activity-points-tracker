package com.example.activitypointstracker.service;

import com.example.activitypointstracker.dto.UserRegistrationDto;
import com.example.activitypointstracker.entity.User;

public interface UserService {
    User save(UserRegistrationDto userDto);
}
