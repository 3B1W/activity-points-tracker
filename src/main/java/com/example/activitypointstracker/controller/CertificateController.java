package com.example.activitypointstracker.controller;


import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.dto.StudentDto;
import com.example.activitypointstracker.entity.Certificate;
import com.example.activitypointstracker.exception.ResourceNotFoundException;
import com.example.activitypointstracker.service.CertificateService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping("/api/certificate")
@CrossOrigin(origins = "http://localhost:63219/")
public class CertificateController {

    private CertificateService certificateService;

    //Build Add Certificate REST API
    @PostMapping("/upload")
    public ResponseEntity<?> addCertificate(@RequestBody CertificateDto certificateDto){
        return certificateService.addCertificate(certificateDto);
    }

    @GetMapping(value = "/all/{tkmid}", produces = "application/json")
    public ResponseEntity<List<Certificate>> getAllCerts(@PathVariable("tkmid") Long id){
        List<Certificate> certificateDtos = certificateService.getAllCertificates(id);
        return ResponseEntity.ok(certificateDtos);
    }

    //Build Update Cert REST API
    @PutMapping("/upload/{id}")
    public ResponseEntity<?> updateCert(@PathVariable("id") Long id,
                                        @RequestBody CertificateDto updatedCertDto) {
        try {
            // Call the service layer to update the certificate
            ResponseEntity<?> updatedCertificate = certificateService.updateCertificate(id, updatedCertDto);

            // Check if the service returned a bad request
            if (updatedCertificate.getStatusCode() == HttpStatus.BAD_REQUEST) {
                return ResponseEntity.badRequest().body(updatedCertificate.getBody());
            }

            // Return the updated certificate details
            return ResponseEntity.ok(updatedCertificate.getBody());
        } catch (ResourceNotFoundException e) {
            // Handle the case where the resource (certificate) was not found
            return new ResponseEntity<>("Certificate with Id " + id + " not found.", HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            // Handle any other errors and return a bad request
            return new ResponseEntity<>("An error occurred while updating the certificate.", HttpStatus.BAD_REQUEST);
        }
    }


    //Build Delete Student REST API
    @DeleteMapping("delete/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable("id") Long id){
        certificateService.deleteCertificate(id);
        return ResponseEntity.ok("Certificate Data Deleted successfully");
    }
}
