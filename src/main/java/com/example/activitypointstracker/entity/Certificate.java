package com.example.activitypointstracker.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "certificates")
public class Certificate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long tkmId;
    //private Student student;// using this as activity points will be updated every time

    @Column(name = "category")
    private String category;

    @Column(name = "subcategory")
    private String subcategory;

    @Column(name = "levelrole")
    private String levelRole;

    @Column(name = "ename")
    private String eventName;

    @Column(name = "durationdate")
    private String durationDate;

    @Column(name = "certlink")
    private String proofCertificate; // Google Drive link

    @Column(name = "points")
    private Integer pointsEarned;

}
