package com.example.activitypointstracker.dto;

import lombok.*;

import java.time.LocalDateTime;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CertificateDto {
    private Long tkmId;
    private String category;
    private String subCategory;
    private String levelRole;
    private String eventName;
    private String durationDate;
    private String proofCertificate;
    private LocalDateTime createdAt;
}
