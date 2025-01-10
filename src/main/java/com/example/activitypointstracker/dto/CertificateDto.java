package com.example.activitypointstracker.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CertificateDto {
    private Long id;
    private Long tkmId;
    private String category;
    private String subCategory;
    private String levelRole;
    private String eventName;
    private String durationDate;
    private String proofCertificate;
    private Integer pointsEarned;
}
