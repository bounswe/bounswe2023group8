package com.bounswe.group8.service;

import com.bounswe.group8.model.IP;
import com.bounswe.group8.payload.IPCreateRequest;
import com.bounswe.group8.repository.IPRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class IPService {

    final IPRepository ipRepository;

    /**
     * Create a new IP in the database
     *
     * @param request IPCreateRequest
     * @return saved IP
     */
    public IP createIP(IPCreateRequest request) {

        IP ip = IP.builder()
                .ip(request.getIp())
                .city(request.getCity())
                .country(request.getCountry())
                .build();

        return ipRepository.save(ip);

    }

    /**
     * Get IP details by ip address
     *
     * @param ip String ip address
     * @return IP details
     */
    public IP getDetailsForIP(String ip) {
        return ipRepository.findByIp(ip);
    }
}