package com.example.activitypointstracker.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StudentDto {
    private Long tkmId;
    private int year;
    private String firstName;
    private String lastName;
    private String email;
    private String rollNo;
    private Integer actpts;
}
