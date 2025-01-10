package com.example.activitypointstracker.dto;

import com.example.activitypointstracker.entity.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Collection;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserRegistrationDto {
    private String fname;
    private String lname;
    private String email;
    private String password;
}
