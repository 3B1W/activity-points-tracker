package com.example.activitypointstracker.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
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
    private String subCategory;

    @Column(name = "levelrole")
    private String levelRole;

    @Column(name = "ename")
    private String eventName;

    @Column(name = "durationdate")
    private String durationDate;

    @Column(name = "certlink")
    private String proofCertificate; // Google Drive link

    @CreationTimestamp
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "points")
    private Integer pointsEarned;

}
