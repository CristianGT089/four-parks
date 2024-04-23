package com.project.layer.Controllers;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.layer.Persistence.Entity.Parking;
import com.project.layer.Services.Map.MapService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/client")
public class ClientController {
    
    private final MapService mapService;


    @Autowired
    public ClientController(MapService mapService) {
        this.mapService = mapService;
    }

    @GetMapping("/getParkings")
    public List<Parking> getParkingsInMap(@RequestParam String city){
        return mapService.getParkingsPerCity(city);
    }

    
}
