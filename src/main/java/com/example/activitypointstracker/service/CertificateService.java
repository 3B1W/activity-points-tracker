package com.example.activitypointstracker.service;

import com.example.activitypointstracker.dto.CertificateDto;
import org.springframework.http.ResponseEntity;

public interface CertificateService {
    ResponseEntity<?> addCertificate(CertificateDto certificateDto);
}
