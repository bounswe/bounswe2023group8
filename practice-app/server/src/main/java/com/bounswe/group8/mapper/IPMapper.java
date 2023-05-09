package com.bounswe.group8.mapper;

import com.bounswe.group8.model.IP;
import com.bounswe.group8.payload.dto.IPDto;

public class IPMapper {
    public static IPDto locationToLocationDto(IP ip) {
        return new IPDto()
                .setId(ip.getId())
                .setIp(ip.getIp())
                .setCity(ip.getCity())
                .setCountry(ip.getCountry());
    }
}
