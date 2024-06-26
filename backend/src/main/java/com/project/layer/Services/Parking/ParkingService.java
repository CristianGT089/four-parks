package com.project.layer.Services.Parking;

import java.lang.reflect.Field;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;

import com.project.layer.Controllers.Requests.ParkingSpaceRequest;
import com.project.layer.Controllers.Responses.ParkingResponse;
import com.project.layer.Controllers.Responses.ParkingsResponse;
import com.project.layer.Persistence.Entity.City;
import com.project.layer.Persistence.Entity.CoordinateID;
import com.project.layer.Persistence.Entity.Parking;
import com.project.layer.Persistence.Entity.ParkingId;
import com.project.layer.Persistence.Entity.ParkingSpace;
import com.project.layer.Persistence.Entity.ParkingSpaceId;
import com.project.layer.Persistence.Entity.UserId;
import com.project.layer.Persistence.Entity.VehicleType;
import com.project.layer.Persistence.Repository.ICityRepository;
import com.project.layer.Persistence.Repository.IParkingRepository;
import com.project.layer.Persistence.Repository.IParkingSpaceRepository;
import com.project.layer.Persistence.Repository.IRateRepository;
import com.project.layer.Persistence.Repository.IReservationRepository;
import com.project.layer.Persistence.Repository.IVehicleTypeRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ParkingService {

    private final IParkingSpaceRepository parkingSpaceRepository;
    private final IParkingRepository parkingRepository;
    private final IRateRepository rateRepository;
    private final IReservationRepository reservationRepository;
    private final IVehicleTypeRepository vehicleTypeRepository;
    private final ICityRepository cityRepository;

    @Transactional
    @Modifying
    public String modifyParking(ParkingId parkingId, Parking parkingChanges) {
        Optional<Parking> optionalParking = parkingRepository.findById(parkingId);
 
        if (optionalParking.isPresent()) {
            Parking parking = optionalParking.get();
 
            // Obtener todas las variables declaradas en la clase Parking
            Field[] fields = Parking.class.getDeclaredFields();
 
            for (Field field : fields) {
                // Hacer que el campo sea accesible, incluso si es privado
                field.setAccessible(true);
 
                try {
                    // Obtener el valor del campo en el objeto parkingChanges
                    Object value = field.get(parkingChanges);
 
                    // Si el valor no es nulo, establecerlo en el objeto parking original
                    if (value != null) {
                        field.set(parking, value);
                    }
                } catch (IllegalAccessException e) {
                    return "No se puede modificar la columna ";
                    // Manejar la excepción si se produce un error al acceder al campo
                }
            }
 
            parkingRepository.save(parking);
            return "Se realizó la modificación";
        } else {
            return "No se encontró ningún estacionamiento con el ID proporcionado";
        }
    }

    public List<Parking> getParkingsByCity(String city, String type, Date startDate, Time startTime, Date endDate, Time endTime, String scheduleType, String vehicleType){

        if(city == null){
            return null;
        }
        
        startDate = (startDate == null) ? Date.valueOf(LocalDate.now()) : startDate;
        endDate = (startDate == null) ? Date.valueOf(LocalDate.now()) : endDate;

        List<Parking> parkings = null;   
        
        parkings = parkingRepository.queryParkingsByArgs(city, type, startTime, endTime, scheduleType);
        startTime = (startTime == null) ? Time.valueOf(LocalTime.now()) : startTime;
        
        System.out.println("----------------------- La fecha es: "+ startDate + " " + startTime + " " +endTime);
        
        for (Parking parking : parkings) {
            if (endTime == null) endTime = parking.getEndTime();
            
            System.out.println("El parqueadero: " + parking.getParkingId().getIdParking());
            
            System.out.println("El tipo de vehiculo: "+vehicleType);
            float busySpaces = reservationRepository.findCountOfBusyParkingSpaces(
                parking.getParkingId().getCity().getIdCity(),
                parking.getParkingId().getIdParking(),
                vehicleType,
                startDate,
                startTime,
                endDate,
                endTime
            );
            
            System.out.println("Ocupabilidad en el parqueadero " + parking.getParkingId().getIdParking() +" Y vehiculo " +vehicleType+": "+ busySpaces);
            
            parking.setCapacity(parkingSpaceRepository.countByParkingAndVehicleType(parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), vehicleType));
            
            float totalSpaces = parking.getCapacity();

            System.out.println("El total de parqueaderos para "+vehicleType+" es: " + totalSpaces);          
            
            if(totalSpaces != 0){
                float percentSpaces = busySpaces/totalSpaces;
                parking.setOcupability(percentSpaces);
            }
            System.out.println("Por lo que el porcentaje de ocupacion es: " + parking.getOcupability());
        }

        return parkings;
    }

    public ParkingResponse getParkingsByCoordinates(float coordinateX, float coordinateY, Date startDate, Time startTime, Date endDate, Time endTime, String idVehicleType) {


        Parking parking = parkingRepository.queryParkingByCoordinates(coordinateX, coordinateY);

        if(parking == null){
            return null;
        }

        List<String> vehicleListType = parkingRepository.getTypeVehicleByParking(parking.getParkingId().getIdParking());

        System.out.println(vehicleListType.toString());
        Map<String, Object> tipoVehiculo = new HashMap<>();

        for (String vehicle : vehicleListType) {
            
            Map<String, Integer> vehicleType = new HashMap<>();
    
            if(parking.getParkingType().getIdParkingType().equals("COV") || parking.getParkingType().getIdParkingType().equals("SEC")) {
                vehicleType.put("covered", parkingRepository.countByCoveredAndParkingAndVehicleType(
                    parking.getParkingId().getIdParking(), false, vehicle));
                vehicleType.put("rate-covered", rateRepository.getHourCostByParkingSpace(
                    parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), vehicle, false
                ));
            }
            if(parking.getParkingType().getIdParkingType().equals("UNC") || parking.getParkingType().getIdParkingType().equals("SEC")) {
                vehicleType.put("uncovered", parkingRepository.countByCoveredAndParkingAndVehicleType(
                    parking.getParkingId().getIdParking(), true, vehicle
                ));
                vehicleType.put("rate-uncovered", rateRepository.getHourCostByParkingSpace(
                    parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), vehicle, true
                ));
            }

            tipoVehiculo.put(vehicle, vehicleType);

        }

        startDate = (startDate == null) ? Date.valueOf(LocalDate.now()) : startDate;
        endDate = (startDate == null) ? Date.valueOf(LocalDate.now()) : endDate;
        startTime = (startTime == null) ? Time.valueOf(LocalTime.now()) : startTime;
        if (endTime == null) endTime = parking.getEndTime();

        float busySpaces = reservationRepository.findCountOfBusyParkingSpaces(
            parking.getParkingId().getCity().getIdCity(),
            parking.getParkingId().getIdParking(),
            idVehicleType,
            startDate,
            startTime,
            endDate,
            endTime
        );

        parking.setCapacity(parkingSpaceRepository.countByParkingAndVehicleType(parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), idVehicleType));
            
        float totalSpaces = parking.getCapacity();  
        
        if(totalSpaces != 0){
            float percentSpaces = busySpaces/totalSpaces;
            parking.setOcupability(percentSpaces);
        }
        System.out.println("Por lo que el porcentaje de ocupacion es: " + parking.getOcupability());

        return ParkingResponse.builder()
                .parking(parking)
                .capacity(tipoVehiculo)
                .build();
    }
 
    @Transactional
    @Modifying
    public String insertParkingSpace(ParkingId parkingId, ParkingSpaceRequest psRequest) {
 
        int lastIdPSValue = parkingSpaceRepository.countByParking(parkingId.getIdParking(), parkingId.getCity().getIdCity());
        Parking parking = parkingRepository.findById(parkingId).get();
 
        for (int i = 0; i < psRequest.getAmount(); i++) {
 
            lastIdPSValue++;
 
            ParkingSpaceId pkID = ParkingSpaceId.builder()
                    .idParkingSpace(lastIdPSValue)
                    .parking(parking)
                    .build();

            VehicleType vehicleType = vehicleTypeRepository.findById(psRequest.vehicleType).get();
 
            ParkingSpace parkingSpace = ParkingSpace.builder()
                    .vehicleType(vehicleType)
                    .isUncovered(psRequest.getIsUncovered())
                    .parkingSpaceId(pkID)
                    .build();
 
            // Guardar el espacio de estacionamiento en la base de datos
            parkingSpaceRepository.save(parkingSpace);
        }
 
        return "Se agregaron correctamente los espacios de los parqueaderos";
    }
 
    @Transactional
    @Modifying
    public String deleteParkingSpace(ParkingId parkingId, ParkingSpaceRequest psRequest) {
 
        // Guardar el espacio de estacionamiento en la base de datos
        parkingSpaceRepository.deleteByParking(
                parkingId.getIdParking(),
                parkingId.getCity().getIdCity(),
                psRequest.getIsUncovered(),
                psRequest.getVehicleType(),
                psRequest.getAmount());
 
        return "Se eliminaron correctamente los espacios de los parqueaderos";
    }

    public ParkingResponse getParkingByAdmin(UserId adminId){

        System.out.println(adminId.getIdDocType()+" xd "+adminId.getIdUser());


        Parking parking = parkingRepository.findByAdminId(adminId.getIdUser(),adminId.getIdDocType());
        System.out.println(parking.toString());
        List<String> vehicleListType = parkingRepository.getTypeVehicleByParking(parking.getParkingId().getIdParking());

        System.out.println(vehicleListType.toString());
        Map<String, Object> tipoVehiculo = new HashMap<>();

        for (String vehicle : vehicleListType) {
            
            Map<String, Integer> vehicleType = new HashMap<>();
    
            if(parking.getParkingType().getIdParkingType().equals("COV") || parking.getParkingType().getIdParkingType().equals("SEC")) {
                vehicleType.put("covered", parkingRepository.countByCoveredAndParkingAndVehicleType(
                    parking.getParkingId().getIdParking(), false, vehicle));
                vehicleType.put("rate-covered", rateRepository.getHourCostByParkingSpace(
                    parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), vehicle, false
                ));
            }
            if(parking.getParkingType().getIdParkingType().equals("UNC") || parking.getParkingType().getIdParkingType().equals("SEC")) {
                vehicleType.put("uncovered", parkingRepository.countByCoveredAndParkingAndVehicleType(
                    parking.getParkingId().getIdParking(), true, vehicle
                ));
                vehicleType.put("rate-uncovered", rateRepository.getHourCostByParkingSpace(
                    parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), vehicle, true
                ));
            }
            tipoVehiculo.put(vehicle, vehicleType);
        }

        Date startDate = Date.valueOf(LocalDate.now());
        Date endDate = Date.valueOf(LocalDate.now());
        Time startTime = Time.valueOf(LocalTime.now());
        Time endTime = parking.getEndTime();

        float busySpaces = reservationRepository.findCountOfBusyParkingSpaces(
            parking.getParkingId().getCity().getIdCity(),
            parking.getParkingId().getIdParking(),
            null,
            startDate,
            startTime,
            endDate,
            endTime
        );

        parking.setCapacity(parkingSpaceRepository.countByParkingAndVehicleType(parking.getParkingId().getIdParking(), parking.getParkingId().getCity().getIdCity(), null));
            
        float totalSpaces = parking.getCapacity();  
        
        if(totalSpaces != 0){
            float percentSpaces = busySpaces/totalSpaces;
            parking.setOcupability(percentSpaces);
        }
        System.out.println("Por lo que el porcentaje de ocupacion es: " + parking.getOcupability());


        return ParkingResponse.builder().parking(parking).capacity(tipoVehiculo).build(); 
    }

    public float getRateByParkingSpace(ParkingSpace parkingSpace) {
        return rateRepository.getHourCostByParkingSpace(
            parkingSpace.getParkingSpaceId().getParking().getParkingId().getIdParking(),
            parkingSpace.getParkingSpaceId().getParking().getParkingId().getCity().getIdCity(),
            parkingSpace.getVehicleType().getIdVehicleType(),
            parkingSpace.isUncovered()
        );
    }

    public ParkingId getParkingId(int idParking, String idCity) {
        return ParkingId.builder()
                    .city(cityRepository.findById(idCity).get())
                    .idParking(idParking)
                    .build();
    }

    public Parking getParkingById(ParkingId parkingId) {
        return parkingRepository.findById(parkingId).get();
    }

    public ParkingsResponse getParkingsBySpot(Map<Integer,CoordinateID> spotCoordinates, float distance) {
        List<City> cities = cityRepository.findAll();
        
        Map<Integer, List<Parking>> parkingsLists = new HashMap<>();
        System.out.println("Las ciudades son:" + cities);
        
        for (Map.Entry<Integer, CoordinateID> entry : spotCoordinates.entrySet()) {
            List<Parking> parkings = new ArrayList<>();
            System.out.println("La clave: " +entry.getKey() + "El valor: " + entry.getValue().toString());
            float coordinateX = entry.getValue().getCoordinatesX();
            float coordinateY = entry.getValue().getCoordinatesY();

            for (City city : cities) {
                if (isCoordinateInCity(coordinateX, coordinateY, city)) {
                    List<Parking> cityParkings = parkingRepository.findByCityId(city.getIdCity());
                    for (Parking parking : cityParkings) {
                        if (isWithinDistance(coordinateX, coordinateY, parking.getAddress().getCoordinatesX(), parking.getAddress().getCoordinatesY(), distance)) {
                            parkings.add(parking);
                        }
                    }
                }
            }
            System.out.println("los parqueaderos son: " + parkings.toString());
            parkingsLists.put(entry.getKey(), parkings);  // Añadimos la lista de parqueaderos al mapa con su clave correspondiente
        }


        return ParkingsResponse.builder()
                            .parkingsLists(parkingsLists)
                            .message("¡Se envian correctamente los parqueaderos cercanos!")
                            .build();
    }

    private boolean isCoordinateInCity(float x, float y, City city) {
        return y >= city.getBLeft() && y <= city.getBRight() && x >= city.getBBottom() && x <= city.getBTop();
    }

    private boolean isWithinDistance(float x1, float y1, float x2, float y2, double maxDistance) {
        double distance = Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
        return distance <= maxDistance;
    }
}
