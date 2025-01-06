package com.example.activitypointstracker.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "students")
public class Student {
    @Id
    private Long tkmId;

    @Column(name="st_year")
    private int year;

    @Column(name="firstname")
    private String firstName;

    @Column(name="lastname")
    private String lastName;

    @Column(name="st_email",nullable = false,unique = true)
    private String email;

    @Column(name="st_roll")
    private String rollNo;

    @Column(name="totalpoints")
    private  Integer actpts;
}
