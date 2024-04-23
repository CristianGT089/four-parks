package com.project.layer.Services.Map;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.layer.Persistence.Entity.Parking;
import com.project.layer.Persistence.Repository.IParkingRepository;

@Service
public class MapService {
    
    @Autowired
    IParkingRepository parkingRepository;

    public MapService(){}

    public List<Parking> getParkingsFilter(String city, String type){

        List<Parking> parkings = null; 

        if (type == null){
            parkings = parkingRepository.queryParkingsByCity(city);
        }else{
            parkings = parkingRepository.queryParkingsByCityAndType(city, type);
        }

        if(parkings == null || parkings.isEmpty()){
            return null;
        }
        
        return parkings;
    }

    public Parking getParkingsPerCoordinates(String coordinateX, String coordinateY) {
        Parking parking = (Parking) parkingRepository.queryParkingByCoordinates(coordinateX, coordinateY);

        if(parking == null){
            return null;
        }

        return parking;
    }

}
