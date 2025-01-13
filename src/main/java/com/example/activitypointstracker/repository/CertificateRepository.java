package com.example.activitypointstracker.repository;

import com.example.activitypointstracker.entity.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CertificateRepository extends JpaRepository<Certificate,Long> {
    Optional<Certificate> findBytkmIdAndEventNameAndDurationDateAndProofCertificate(Long tkmId, String eventName, String durationDate, String proofCertificate);
    long countByTkmIdAndSubCategory(Long tkmid, String subcat);
    List<Certificate> findByTkmId(Long tkmid);

}
