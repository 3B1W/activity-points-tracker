package com.example.activitypointstracker.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class StudentDto {
    private Long tkmId;
    private int year;
    private String firstName;
    private String lastName;
    private String email;
    private String rollNo;
    private Integer actpts;
}
