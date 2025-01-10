package com.example.activitypointstracker.controller;


import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.service.CertificateService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/api/certificate")
public class CertificateController {

    private CertificateService certificateService;

    //Build Add Certificate REST API
    @PostMapping("upload")
    public ResponseEntity<?> addCertificate(@RequestBody CertificateDto certificateDto){
        return certificateService.addCertificate(certificateDto);
    }

    @GetMapping
    public ResponseEntity<List<StudentDto>> getAllEmployees(){
        List<StudentDto> students = studentservice.getAllStudents();
        return ResponseEntity.ok(students);
    }

    //Build Update Cert REST API
    @PutMapping("/update/{id}")
    public ResponseEntity<CertificateDto> updateStudent(@PathVariable("id") Long id,
                                                    @RequestBody CertificateDto updatednew){
        CertificateDto updatedCert = certificateService.updateCert(id,updatednew);
        return ResponseEntity.ok(updatedCert);
    }

    //Build Delete Student REST API
    @DeleteMapping("delete/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable("id") Long id){
        certificateService.deleteCert(id);
        return ResponseEntity.ok("Certificate Data Deleted successfully");
    }
}
