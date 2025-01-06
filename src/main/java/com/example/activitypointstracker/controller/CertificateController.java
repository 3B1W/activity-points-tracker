package com.example.activitypointstracker.controller;


import com.example.activitypointstracker.dto.CertificateDto;
import com.example.activitypointstracker.service.CertificateService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
