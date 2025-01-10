package com.example.activitypointstracker.mapper;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.entity.Certificate;

import java.time.LocalDateTime;

public class CertificateMapper {
    public static Certificate maptoCert(CertificateDto certificateDto) {
        Certificate certificate = new Certificate();
        certificate.setId(certificateDto.getId());
        certificate.setTkmId(certificateDto.getTkmId());
        certificate.setCategory(certificateDto.getCategory());
        certificate.setSubCategory(certificateDto.getSubCategory());
        certificate.setLevelRole(certificateDto.getLevelRole());
        certificate.setEventName(certificateDto.getEventName());
        certificate.setDurationDate(certificateDto.getDurationDate());
        certificate.setProofCertificate(certificateDto.getProofCertificate());
        certificate.setPointsEarned(certificateDto.getPointsEarned());

        // Set the current time for createdAt
        certificate.setCreatedAt(LocalDateTime.now());

        return certificate;
    }

    public static CertificateDto maptoCertDto(Certificate certificate) {
        return new CertificateDto(
                certificate.getId(),
                certificate.getTkmId(),
                certificate.getCategory(),
                certificate.getSubCategory(),
                certificate.getLevelRole(),
                certificate.getEventName(),
                certificate.getDurationDate(),
                certificate.getProofCertificate(),
                certificate.getPointsEarned()
        );
    }
}
