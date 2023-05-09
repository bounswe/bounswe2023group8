package com.bounswe.group8.repository;

import com.bounswe.group8.model.IP;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface IPRepository extends JpaRepository<IP, Long> {
    IP findByIp(String ip);
}