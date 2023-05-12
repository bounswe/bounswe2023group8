package com.bounswe.group8.service.bahri;
import com.bounswe.group8.model.bahri.City;
import com.bounswe.group8.payload.bahri.CityCreateRequest;
import com.bounswe.group8.repository.bahri.CityRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CityService {

    final CityRepository cityRepository;

    /**
     * Create a new City in the database
     *
     * @param request CityCreateRequest
     * @return saved City
     */
    public City createCity(CityCreateRequest request) {

        City city = City.builder()
                .name(request.getName())
                .country(request.getCountry())
                .population(request.getPopulation())
                .build();

        return cityRepository.save(city);

    }

    /**
     * Get City details by name
     *
     * @param name String name of the city
     * @return City details
     */
    public City getDetailsForCity(String name) {
        return cityRepository.findByName(name);
    }
}

