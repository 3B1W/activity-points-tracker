package com.example.activitypointstracker.mapper;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.entity.Certificate;

public class CertificateMapper {

    // Map from Certificate entity to CertificateDto
    public static CertificateDto maptoCertDto(Certificate certificate) {
        if (certificate == null) {
            return null;
        }

        return new CertificateDto(
                certificate.getTkmId(),
                certificate.getCategory(),
                certificate.getSubCategory(),
                certificate.getLevelRole(),
                certificate.getEventName(),
                certificate.getDurationDate(),
                certificate.getProofCertificate(),
                certificate.getCreatedAt() // Map the createdAt field
        );
    }

    // Map from CertificateDto to a NEW Certificate entity
    public static Certificate maptoCert(CertificateDto certificateDto) {
        if (certificateDto == null) {
            return null;
        }

        return Certificate.builder()
                .tkmId(certificateDto.getTkmId())
                .category(certificateDto.getCategory())
                .subCategory(certificateDto.getSubCategory())
                .levelRole(certificateDto.getLevelRole())
                .eventName(certificateDto.getEventName())
                .durationDate(certificateDto.getDurationDate())
                .proofCertificate(certificateDto.getProofCertificate())
                .pointsEarned(0) // Default value for points
                // createdAt is not explicitly set here, as it will be auto-populated by @CreationTimestamp
                .build();
    }

    // Update an existing Certificate entity with data from CertificateDto
    public static Certificate updateExistingCert(Certificate existingCert, CertificateDto certificateDto) {
        if (existingCert == null || certificateDto == null) {
            return existingCert; // Return the existing entity as-is if inputs are null
        }

        // Update fields of the existing entity with values from the DTO
        existingCert.setTkmId(certificateDto.getTkmId());
        existingCert.setCategory(certificateDto.getCategory());
        existingCert.setSubCategory(certificateDto.getSubCategory());
        existingCert.setLevelRole(certificateDto.getLevelRole());
        existingCert.setEventName(certificateDto.getEventName());
        existingCert.setDurationDate(certificateDto.getDurationDate());
        existingCert.setProofCertificate(certificateDto.getProofCertificate());

        // Note: Do not overwrite `pointsEarned` or `createdAt` unless explicitly required

        return existingCert;
    }
}
