package com.example.activitypointstracker.mapper;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.entity.Certificate;

public class CertificateMapper {
    public static CertificateDto maptoCertDto(Certificate certificate){
        return new CertificateDto(
                certificate.getId(),
                certificate.getTkmId(),
                certificate.getCategory(),
                certificate.getSubcategory(),
                certificate.getLevelRole(),
                certificate.getEventName(),
                certificate.getDurationDate(),
                certificate.getProofCertificate(),
                certificate.getPointsEarned()
        );
    }

    public static Certificate maptoCert(CertificateDto certificateDto){
        return new Certificate(
                certificateDto.getId(),
                certificateDto.getTkmId(),
                certificateDto.getCategory(),
                certificateDto.getSubcategory(),
                certificateDto.getLevelRole(),
                certificateDto.getEventName(),
                certificateDto.getDurationDate(),
                certificateDto.getProofCertificate(),
                certificateDto.getPointsEarned()
        );
    }
}
