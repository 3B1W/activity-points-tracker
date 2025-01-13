package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Certificate;
import com.example.activitypointstracker.entity.Student;
import com.example.activitypointstracker.exception.ResourceNotFoundException;
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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class CertificateServiceImpl implements CertificateService {

    private final CertificateRepository certificateRepository;
    private final PointCalculator pointCalculator;
    private final StudentRepository studentRepository;
    private final StudentService studentService;

    public Long validatePoint(Long tkmId, String subCategory) {
        return certificateRepository.countByTkmIdAndSubCategory(tkmId, subCategory);
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
        if (existingCert.isPresent()) {
            return new ResponseEntity<>("This certificate already exists.", HttpStatus.BAD_REQUEST);
        }

        // Calculate points using PointsCalculator
        int points = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubCategory(), certificateDto.getLevelRole());
        System.out.println("Calculated points: " + points);

        // Map DTO to a new entity
        Certificate certificate = CertificateMapper.maptoCert(certificateDto);

        // Set the calculated points in the certificate entity
        certificate.setPointsEarned(points);

        // Save the new certificate
        Certificate newCert = certificateRepository.save(certificate);

        // Update the student points
        Student oldStudData = studentRepository.findByTkmId(certificateDto.getTkmId());
        System.out.println("Old student data: " + oldStudData);

        if (oldStudData.getActpts() == null) {
            oldStudData.setActpts(points);
        } else {
            System.out.println("Old Points: " + oldStudData.getActpts());
            if ("MOOC with Final Assessment Certificate".equals(certificateDto.getSubCategory())) {
                if (validatePoint(oldStudData.getTkmId(), "MOOC with Final Assessment Certificate") == 0) {
                    oldStudData.setActpts(oldStudData.getActpts() + points);
                }
            } else {
                oldStudData.setActpts(oldStudData.getActpts() + points);
            }
        }

        StudentDto newStudentDto = StudentMapper.mapToStudentDto(oldStudData);
        System.out.println("Updating student with: " + newStudentDto);
        StudentDto updatedStudentDto = studentService.updateStudent(oldStudData.getId(), newStudentDto);

        // Return the saved certificate with points
        System.out.println("Returning certificate with points: " + newCert);
        return new ResponseEntity<>(CertificateMapper.maptoCertDto(newCert), HttpStatus.CREATED);
    }

    @Override
    public ResponseEntity<?> updateCertificate(Long id, CertificateDto certificateDto) {
        // Find the existing certificate
        Certificate existingCert = certificateRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Certificate with Id not found: " + id)
        );

        // Check for duplication
        Optional<Certificate> duplicateCert = certificateRepository.findBytkmIdAndEventNameAndDurationDateAndProofCertificate(
                certificateDto.getTkmId(),
                certificateDto.getEventName(),
                certificateDto.getDurationDate(),
                certificateDto.getProofCertificate()
        );
        if (duplicateCert.isPresent() && !duplicateCert.get().getId().equals(id)) {
            return new ResponseEntity<>("This certificate already exists.", HttpStatus.BAD_REQUEST);
        }

        // Store old points
        int oldPoints = existingCert.getPointsEarned();

        // Update the certificate entity
        CertificateMapper.updateExistingCert(existingCert, certificateDto);

        // Recalculate and update points if necessary
        int newPoints = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubCategory(), certificateDto.getLevelRole());
        if (oldPoints != newPoints) {
            existingCert.setPointsEarned(newPoints);
            Student oldStudData = studentRepository.findByTkmId(certificateDto.getTkmId());
            oldStudData.setActpts(oldStudData.getActpts() + newPoints - oldPoints);

            StudentDto updatedStudentDto = StudentMapper.mapToStudentDto(oldStudData);
            System.out.println("Updating student with: " + updatedStudentDto);
            studentService.updateStudent(oldStudData.getId(), updatedStudentDto);
        }

        // Save the updated certificate
        Certificate updatedCert = certificateRepository.save(existingCert);

        // Return the updated certificate DTO
        CertificateDto updatedCertDto = CertificateMapper.maptoCertDto(updatedCert);
        return ResponseEntity.ok(updatedCertDto);
    }

    @Override
    public void deleteCertificate(Long id) {
        Certificate cert = certificateRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Certificate with Id not found: " + id)
        );
        certificateRepository.deleteById(id);
    }

    @Override
    public List<Certificate> getAllCertificates(Long tkmId) {
        List<Certificate> certs = certificateRepository.findByTkmId(tkmId);
        return certs;
    }
}


/*
package com.example.activitypointstracker.service.impl;

import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Certificate;
import com.example.activitypointstracker.entity.Student;
import com.example.activitypointstracker.exception.ResourceNotFoundException;
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

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class CertificateServiceImpl implements CertificateService {

    private CertificateRepository certificateRepository;
    private PointCalculator pointCalculator;
    private StudentRepository studentRepository;
    private StudentService studentservice;

    public Long validatePoint(Long tkmid, String subcategory) {
        return certificateRepository.countByTkmIdAndSubCategory(tkmid, subcategory);
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
        if (existingCert.isPresent()) {
            return new ResponseEntity<>("This certificate already exists.", HttpStatus.BAD_REQUEST);
        }

        // Calculate points using PointsCalculator
        int points = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubCategory(), certificateDto.getLevelRole());
        System.out.println("Calculated points: " + points);

        // Map DTO to entity
        Certificate certificate = CertificateMapper.maptoCert(certificateDto);

        // Set the calculated points in the certificate entity
        certificate.setPointsEarned(points);

        // Save the new certificate with points
        Certificate newCert = certificateRepository.save(certificate);

        // Update the student points
        Student oldStudData = studentRepository.findByTkmId(certificateDto.getTkmId());
        System.out.println("Old student data: " + oldStudData);

        if (oldStudData.getActpts() == null) {
            oldStudData.setActpts(points);
        }
        else{
            System.out.println("Old Points: " + oldStudData.getActpts());
            if(certificateDto.getSubCategory().equals("MOOC with Final Assessment Certificate")){
                if (validatePoint(oldStudData.getTkmId(), "MOOC with Final Assessment Certificate")==0) {
                    oldStudData.setActpts(oldStudData.getActpts() + points);
                }
            }
            else {
                oldStudData.setActpts(oldStudData.getActpts()+points);
            }
        }

        StudentDto newStudentDto = StudentMapper.mapToStudentDto(oldStudData);
        System.out.println("Updating student with: " + newStudentDto);
        StudentDto updatedStudentDto = studentservice.updateStudent(oldStudData.getId(), newStudentDto);

        // Return the saved certificate with points
        System.out.println("Returning certificate with points: " + newCert);
        return new ResponseEntity<>(CertificateMapper.maptoCertDto(newCert), HttpStatus.CREATED);
    }

    @Override
    public ResponseEntity<?> updateCertificate(Long id, CertificateDto certificateDto) {
        Certificate certificate = certificateRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Certificate with Id not found:"+id)
        );
        int oldPoints = certificate.getPointsEarned();

        certificate.setEventName(certificateDto.getEventName());
        certificate.setCategory(certificateDto.getCategory());
        certificate.setSubCategory(certificateDto.getSubCategory());
        certificate.setLevelRole(certificateDto.getLevelRole());
        certificate.setDurationDate(certificateDto.getDurationDate());
        certificate.setProofCertificate(certificateDto.getProofCertificate());
        Optional<Certificate> existingCert = certificateRepository.findBytkmIdAndEventNameAndDurationDateAndProofCertificate(
                certificateDto.getTkmId(),
                certificateDto.getEventName(),
                certificateDto.getDurationDate(),
                certificateDto.getProofCertificate()
        );
        if (existingCert.isPresent()) {
            return new ResponseEntity<>("This certificate already exists.", HttpStatus.BAD_REQUEST);
        }

        int points = pointCalculator.calculatePoints(certificateDto.getCategory(), certificateDto.getSubCategory(), certificateDto.getLevelRole());
        Certificate updatedcert = certificateRepository.save(certificate);

        if(oldPoints!=points){
            Student oldStudData = studentRepository.findByTkmId(certificateDto.getTkmId());
            oldStudData.setActpts(oldStudData.getActpts() + points - oldPoints);
            StudentDto newStudentDto = StudentMapper.mapToStudentDto(oldStudData);
            System.out.println("Updating student with: " + newStudentDto);
            StudentDto updatedStudentDto = studentservice.updateStudent(oldStudData.getId(), newStudentDto);
        }

        CertificateDto updatedCertDto = CertificateMapper.maptoCertDto(updatedcert);
        return ResponseEntity.ok(updatedCertDto);
    }

    @Override
    public void deleteCertificate(Long id) {
        Certificate cert = certificateRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Certificate with Id not found:"+id)
        );
        certificateRepository.deleteById(id);
    }

    @Override
    public List<CertificateDto> getAllCertificates(Long tkmid) {
        List<Certificate> certs = certificateRepository.findAll();
        return certs.stream().map((cert) -> CertificateMapper.maptoCertDto(cert))
                .collect(Collectors.toList());
    }

}

*/
