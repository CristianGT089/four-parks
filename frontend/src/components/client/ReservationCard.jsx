import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import Swal from 'sweetalert2'
import coveredIcon from '../../assets/Parking Icons/Covered-Transparent.png';
import uncoveredIcon from '../../assets/Parking Icons/Uncovered-Transparent.png';
import semicoveredIcon from '../../assets/Parking Icons/Semicovered-Transparent.png';

function ReservationCard({url, setOnReservationForm, actualParking, actualCity }) {
    const [resStartDate, setResStartDate]= useState('');
    const [resEndDate, setResEndDate]= useState('');
    const [resStart, setResStart] = useState('');
    const [resEnd, setResEnd] = useState('');
    const [resCreationDate, setResCreationDate] = useState('');
    const [resTotal, setResTotal] = useState('');
    const [licensePlate, setLicensePlate] = useState('');
    const [vehicleType, setVehicleType] = useState('');
    const [resPayMethod, setResPayMethod] = useState('');
    const [price, setPrice] = useState('');
    const [fieldParking, setFieldParking] = useState('');


    const carCompData = actualParking[1].CAR;
    const motCompData = actualParking[1].MOT;
    const bicCompData = actualParking[1].BIC;

    function calculatePrice(param) {
        let x
        //console.log(resStart)
        let a = parseInt(resStart,10)
        let b = parseInt(resEnd,10)
        if (b < a) {
            b += 24;
        }
        x = b - a; 
        console.log(x)
        let precio = x*param;
        setPrice(precio)
    }
    
    const navigate = useNavigate();
    //Hacer calculo de tarifa
    const idCiudad = actualCity.id;
    let tipoParkeadero = actualParking[0].parkingType.idParkingType;


    useEffect(() => {
        if (tipoParkeadero !== "SEC") {
            setFieldParking(tipoParkeadero);
            console.log(fieldParking)
        }
    }, [tipoParkeadero]);
 
    useEffect(() => {
        //console.log(tipoParkeadero) 
        let precioVehiculoCarroDescubierto;
        let precioVehiculoCarroCubierto;
        let precioVehiculoMotoDescubierto;
        let precioVehiculoMotoCubierto;
        let precioVehiculoBiciDescubierto;
        let precioVehiculoBiciCubierto;
    
        if (actualParking && actualParking[1]) {
            const carData = actualParking[1].CAR;
            const motData = actualParking[1].MOT;
            const bicData = actualParking[1].BIC;
    
            if (carData) {
                precioVehiculoCarroDescubierto = carData["rate-uncovered"];
                precioVehiculoCarroCubierto = carData["rate-covered"];
            }
    
            if (motData) {
                precioVehiculoMotoDescubierto = motData["rate-uncovered"];
                precioVehiculoMotoCubierto = motData["rate-covered"];
            }
    
            if (bicData) {
                precioVehiculoBiciDescubierto = bicData["rate-uncovered"];
                precioVehiculoBiciCubierto = bicData["rate-covered"];
            }
        }
    
        if (precioVehiculoCarroDescubierto !== undefined && vehicleType=="CAR" && fieldParking=="UNC") {
            console.log(precioVehiculoCarroDescubierto);
            calculatePrice(precioVehiculoCarroDescubierto)
        }
        if (precioVehiculoCarroCubierto !== undefined && vehicleType=="CAR" && fieldParking=="COV") {
            console.log(precioVehiculoCarroCubierto);
            calculatePrice(precioVehiculoCarroCubierto)
        }
        if (precioVehiculoMotoDescubierto !== undefined && vehicleType=="MOT" && fieldParking=="UNC") {
            console.log(precioVehiculoMotoDescubierto);
            calculatePrice(precioVehiculoMotoDescubierto)
        }
        if (precioVehiculoMotoCubierto !== undefined && vehicleType=="MOT" && fieldParking=="COV") {
            console.log(precioVehiculoMotoCubierto);
            calculatePrice(precioVehiculoMotoCubierto)
        }
        if (precioVehiculoBiciDescubierto !== undefined && vehicleType=="BIC" && fieldParking=="UNC") {
            console.log(precioVehiculoBiciDescubierto);
            calculatePrice(precioVehiculoBiciDescubierto)
        }
        if (precioVehiculoBiciCubierto !== undefined && vehicleType=="BIC" && fieldParking=="COV") {
            console.log(precioVehiculoBiciCubierto);
            calculatePrice(precioVehiculoBiciCubierto)
        }
    },[vehicleType, resStart, resEnd, fieldParking]);


 
    

    const handleTimeChange = (setter) => (event) => {
        const time = new Date(event.target.valueAsNumber);
        if (time) {
          time.setMinutes(0);
          time.setSeconds(0);
          setter(time.toISOString().substr(11, 8));
        }
      };

    
    const handleReservation = (e) => {
        e.preventDefault();
        const token = sessionStorage.getItem('token').replace(/"/g, '');

        const user =JSON.parse(sessionStorage.getItem('userLogged'));
        const idNumber = user.idNumber;  
        const idType = user.idType;

        if(!resStartDate ||!resEndDate || !resStart || !resEnd || !licensePlate || !vehicleType || !resPayMethod) {
            Swal.fire({
                icon: 'info',
                title: `Por favor llene todos los campos`
            });
        } else {
            console.log(resStartDate,resStart,resEnd,licensePlate)
            axios.post(`${url}/client/startReservation`, {
                dateRes: resStartDate, 
                //xxxdateendresxxx: resEndDate,
                startTimeRes: resStart, 
                endTimeRes: resEnd, 
                licensePlate: licensePlate,
                clientId:{
                    idUser:idNumber,idDocType:idType
                },
                cityId:idCiudad,
                parkingId:idParqueadero,
                vehicleType:vehicleType
                //creationDateRes: 'Hoy',
                //totalRes: "0", 
                //vehicleType: vehicleType, 
                //username: resPayMethod, 
            },{headers: {Authorization: `Bearer ${token}`}})
            .then(res => {
                console.log(res)
                console.log(res.data);
                if ((res.data)==("No hay espacios disponibles")) {
                    Swal.fire({
                        icon: 'error',
                        title: `No hay espacios disponibles` ,
                    });
                }else{
                    Swal.fire({
                    icon: 'success',
                    title: `Reserva exitosa`
                });

                setOnReservationForm(false)}
                

                //navigate("/inicio-sesion");
            })
            .catch(err => {
                Swal.fire({
                    icon: 'error',
                    title: `Hubo un error al realizar la reserva` ,
                });

                console.log(err);
            })
        }
    }

    const getIcon = () => {
        switch (actualParking[0].parkingType.idParkingType) {
            case 'COV':
                return coveredIcon;
            case 'UNC':
                return uncoveredIcon;
            case 'SEC':
                return semicoveredIcon;
            default:
                return coveredIcon;
        }
    };

    return (
        <article className="bg-blue-light mt-12 pt-5 pb-6 relative rounded-2xl shadow-xl">
            <section className="flex flex-col items-center px-6">
                <section className="w-full flex justify-between">
                    <div className="w-1/6 flex justify-center rounded-md border-2 border-black">
                            <img className="w-16" src={getIcon()} alt="Imagen que identifica el tipo de parqueadero"/>
                    </div>

                    <section className="flex flex-col justify-evenly items-center w-4/5 h-16">
                        <h1 className="text-center text-title font-semibold text-lg"> {actualParking[0].namePark}</h1>
                        <span className="w-full h-0.5 rounded-full bg-black"></span>
                    </section>
                </section>

                <section className="flex flex-col justify-evenly items-center w-full h-22 mt-8">
                    <div className="flex justify-between w-full mb-5">
                        <input type="date" id="resStartDate" className="w-2/5 p-3 rounded-md bg-white font-paragraph mr-4" value={resStartDate} 
                        onChange={(e) => setResStartDate(e.target.value)}></input>

                        <input type="date" id="resStartDate" className="w-2/5 p-3 rounded-md bg-white font-paragraph mr-4" value={resEndDate} 
                        onChange={(e) => setResEndDate(e.target.value)}></input>

                        <input type="time" id="resStart" className="w-2/5 p-3 rounded-md bg-white font-paragraph mr-4" value={resStart} 
                        onChange={handleTimeChange(setResStart)}></input>

                        <input type="time" id="resEnd"className="w-2/5 p-3 rounded-md bg-white font-paragraph" placeholder="Hora fin" value={resEnd} 
                        onChange={handleTimeChange(setResEnd)}></input>
                    </div>
                
                    <div className="flex justify-between w-full mb-5">
                        <select id="vehicleType" className="w-2/5 p-3 rounded-md bg-white font-paragraph mr-4" value={vehicleType} onChange={(e) => setVehicleType(e.target.value)}>
                            <option value="" disabled hidden> Tipo de vehiculo </option>
                            <option value=""></option>
                            {motCompData?<option value="MOT">Moto</option>:<></>}
                            {carCompData?<option value="CAR">Carro</option>:<></>}
                            {bicCompData?<option value="BIC">Bicicleta</option>:<></>}
                        </select>
                        
                        {tipoParkeadero=="SEC" ?  <select id="fieldParking" className="w-2/5 p-3 rounded-md bg-white font-paragraph mr-4" value={fieldParking} onChange={(e) => setFieldParking(e.target.value)}>
                            <option value="" disabled hidden> Tipo de plaza </option>
                            <option value=""></option>
                            <option value="COV">Cubierta</option>
                            <option value="UNC">Descubierta</option>
                            
                        </select> :<></>}

                        <input id="licensePlate" className="w-2/5 p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark" placeholder="Matricula del vehiculo"
                        value={licensePlate} onChange={(e) => setLicensePlate(e.target.value)}></input>
                    </div>
                
                    <div className="w-full">
                        <select id="resPayMethod" className="w-full p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark" value={resPayMethod} 
                        onChange={(e) => setResPayMethod(e.target.value)}>
                            <option value="" disabled hidden> Metodo de pago </option>
                            <option value=""></option>
                            <option value="5104499087433833">5104499087433833</option>
                            <option value="Nequi">Nequi</option>
                        </select>
                    </div>

                    <div className="flex justify-between w-full mt-5">
                        <div className="text font-semibold text-lg">Total Reserva: ${resStart=="" || resEnd=="" ? " " :price}</div>
                        <hr className="h-0.5 rounded-full bg-blue-light"></hr>
                    </div>
                </section>  

                <div className="flex justify-between">
                    <button className="mt-8 px-10 py-3 mr-8 bg-blue-dark hover:bg-blue-darkest rounded-xl text-white font-title font-semibold" 
                    onClick={handleReservation}> Realizar reserva </button>
                    <button className="mt-8 px-10 py-3 bg-red-dark hover:bg-red-darkest rounded-xl text-white font-title font-semibold" 
                    onClick={() => setOnReservationForm(false)}> Cancelar </button>
                </div>
            </section>
        </article>
    )
}

export default ReservationCard;