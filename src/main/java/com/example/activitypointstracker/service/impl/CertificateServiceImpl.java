package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.entity.Certificate;
import com.example.activitypointstracker.mapper.CertificateMapper;
import com.example.activitypointstracker.repository.CertificateRepository;
import com.example.activitypointstracker.service.CertificateService;
import com.example.activitypointstracker.utils.PointCalculator;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class CertificateServiceImpl implements CertificateService {

    private CertificateRepository certificateRepository;
    private PointCalculator pointCalculator;

    @Override
    public ResponseEntity<?> addCertificate(CertificateDto certificateDto) {
        // Handle duplication
        Optional<Certificate> existingCert = certificateRepository.findBytkmIdAndEventNameAndDurationDateAndProofCertificate(
                certificateDto.getTkmId(),
                certificateDto.getEventName(),
                certificateDto.getDurationDate(),
                certificateDto.getProofCertificate()
        );
        if(existingCert.isPresent()){
            return new ResponseEntity<>("This certificate already exists.", HttpStatus.BAD_REQUEST);
        }

        // Calculate points using PointsCalculator
        int points = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubcategory(), certificateDto.getLevelRole());
        //System.out.println(points);
        // Map DTO to entity
        Certificate certificate = CertificateMapper.maptoCert(certificateDto);

        // Set the calculated points in the certificate entity
        certificate.setPointsEarned(points);

        // Save the new certificate with points
        Certificate newCert = certificateRepository.save(certificate);

        // Return the saved certificate with points
        return new ResponseEntity<>(CertificateMapper.maptoCertDto(newCert), HttpStatus.CREATED);
    }
}
