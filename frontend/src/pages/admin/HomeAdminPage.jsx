import { useEffect, useState } from "react";
import axios from "axios";
import Header from "../../components/admin/Header"
import Map from '../../components/admin/Map.jsx'
import ParamsInfo from '../../components/admin/ParamsInfo.jsx'
import QuotaManager from "../../components/admin/QuotaManager.jsx";

const HomeManagerPage = ({url}) => {
  const [actualCity, setActualCity] = useState();
  const [actualParking, setActualParking] = useState();
  const [canEditSpaces, setCanEditSpaces] = useState(false);

  useEffect(() => {
    const token = sessionStorage.getItem('token').replace(/"/g, '');
    const user = JSON.parse(sessionStorage.getItem('userLogged'));
    
    axios.get(`${url}/parking/admin/${user.idType}/${user.idNumber}`, {headers: {Authorization: `Bearer ${token}`}})
    .then(res => {
        setActualParking([res.data.parking, res.data.capacity]);

        const city = res.data.parking.parkingId.city;
        setActualCity({
            id: city.idCity,
            name: city.name,
            northLim: [city.btop, city.bleft],
            southLim: [city.bbottom, city.bright],
            centerCoords: [res.data.parking.address.coordinatesX, res.data.parking.address.coordinatesY]
        });
    })
    .catch(err => {
        console.error(err);
    });
}, []);

  return (
    <>
        <Header />
        <section className='flex h-screen px-12 py-36 bg-gray-light'> 
          <section className="w-1/2 rounded-2xl z-0"> 
            <Map url={url} actualCity={actualCity} setActualCity={setActualCity} actualParking={actualParking} setActualParking={setActualParking} />
          </section>

          <section className='w-2/5 ml-48 mt-16 z-0'>
            {
              !canEditSpaces ? (<ParamsInfo url={url} actualCity={actualCity} actualParking={actualParking} setCanEditSpaces={setCanEditSpaces} />) : 
              (<QuotaManager url={url} actualParking={actualParking} setCanEditSpaces={setCanEditSpaces} />)
            }
          </section>
        </section>
    </>
  )
}

export default HomeManagerPage