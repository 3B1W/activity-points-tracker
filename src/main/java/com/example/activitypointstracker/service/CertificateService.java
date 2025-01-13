package com.example.activitypointstracker.service;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Certificate;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface CertificateService {
    ResponseEntity<?> addCertificate(CertificateDto certificateDto);
    ResponseEntity<?> updateCertificate(Long id,CertificateDto certificateDto);
    void deleteCertificate(Long id);
    List<Certificate> getAllCertificates(Long tkmid);
}
