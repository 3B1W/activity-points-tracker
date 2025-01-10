package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Certificate;
import com.example.activitypointstracker.entity.Student;
import com.example.activitypointstracker.mapper.CertificateMapper;
import com.example.activitypointstracker.mapper.StudentMapper;
import com.example.activitypointstracker.repository.CertificateRepository;
import com.example.activitypointstracker.repository.StudentRepository;
import com.example.activitypointstracker.service.CertificateService;
import com.example.activitypointstracker.service.StudentService;
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
    private StudentRepository studentRepository;
    private StudentService studentservice;

    public boolean validatePoint(Long tkmid,String subcategory){
        return certificateRepository.findBytkmIdAndSubCategory(tkmid, subcategory).isPresent();
    }

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
        int points = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubCategory(), certificateDto.getLevelRole());
        //System.out.println(points);
        // Map DTO to entity
        Certificate certificate = CertificateMapper.maptoCert(certificateDto);

        // Set the calculated points in the certificate entity
        certificate.setPointsEarned(points);

        // Save the new certificate with points
        Certificate newCert = certificateRepository.save(certificate);

        //Update the student points
        Student oldStudData = studentRepository.findByTkmId(certificate.getTkmId());
        if(!validatePoint(oldStudData.getTkmId(), certificateDto.getSubCategory())){
            oldStudData.setActpts(oldStudData.getActpts() + points);
            StudentDto newStudentDto = StudentMapper.mapToStudentDto(oldStudData);
            StudentDto updatedStudentDto = studentservice.updateStudent(newCert.getId(),newStudentDto);
        }

        // Return the saved certificate with points
        return new ResponseEntity<>(CertificateMapper.maptoCertDto(newCert), HttpStatus.CREATED);
    }
}
