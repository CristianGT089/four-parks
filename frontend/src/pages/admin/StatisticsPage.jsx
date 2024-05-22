import { useState, useEffect } from "react";
import axios from "axios";
import Header from "../../components/admin/Header"
import BarHours from "../../components/admin/graphics/BarHours";
import { jsPDF } from "jspdf";
import { read, writeFileXLSX } from "xlsx";


const StatisticsPage = ({url}) => {
  const [infoType, setInfoType] = useState('');
  const [graphicType, setGraphicType] = useState('');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [parkings, setParkings] = useState([]);
  const [actualParkingID, setActualParkingID] = useState();

  useEffect(() => {
        const token = sessionStorage.getItem('token').replace(/"/g, '');
        const user = JSON.parse(sessionStorage.getItem('userLogged'));
        
        axios.post(`${url}/admin/searchParkings`, {idUser: user.idNumber, idDocType: user.idType}, {headers: { Authorization: `Bearer ${token}` }})
        .then(res => {
            const parkingArray = res.data.map(parking => ({
                id: parking.parking.idParking,
                name: parking.parking.namePark,
            }));

            setParkings(parkingArray);
        })
        .catch(err => {
            console.error(err.response || err);
        });
    }, []);

    useEffect(() => {
      if(actualParkingID && infoType && graphicType && startDate && endDate) {
        if(infoType == 'hours') {
          
        }
      }
    }, [actualParkingID, infoType, graphicType, startDate, endDate])

    const handleParkingChange = (e) => {
      const selectedIndex = e.target.value;
      setActualParkingID(parkings[selectedIndex]);
    };
    
    const createHoursGraphic = () => {
      return <BarHours url={url} actualParkingID={actualParkingID} startDate={startDate} endDate={endDate} />
    }

    const renderSelectedGraph = () => {
      /*switch (selectedGraph) {
          case 'bar':
              return <BarGraphic bdurl={bdurl}/>;
          case 'doughnut':
              return <Pies bdurl={bdurl} />;
          case 'map':
              return <Map bdurl={bdurl} />;
          default:
              return null;
      }*/


      if(actualParkingID && infoType && graphicType && startDate && endDate) {
        if(infoType == 'hours') {
          return <BarHours url={url} actualParkingID={actualParkingID} startDate={startDate} endDate={endDate} />
        }
      }
  };


  const GenPDF = ()=>{
    const doc = new jsPDF();
    doc.text("Gráfica:", 95,20);
    doc.save("Estadisticas.pdf");
  }

  return (
    <>
        <Header />

        <section className='h-screen px-12 py-36 bg-gray-light'>   
          <section className="flex justify-between w-full">
            <select id="statistics-info" value={infoType} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph" 
            onChange={(e) => setInfoType(e.target.value)}>
                <option value="" disabled selected hidden> Tipo de información </option>
                <option value=""></option>
                <option value="hours"> Horas pico / valle </option>
                <option value="sales"> Ventas </option>
            </select>
            
            <select id="statistics-graphic" value={graphicType} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setGraphicType(e.target.value)}>
                <option value="" disabled selected hidden> Tipo de gráfica </option>
                <option value=""></option>
                <option value="circle"> Circular </option>
                <option value="bars"> Barras </option>
                <option value="lines"> Línea </option>
            </select>
            
            <select id="statistics-parkings" value={actualParkingID} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph" 
            onChange={(e) => setActualParkingID(e.target.value)}>
                <option value="" disabled selected hidden> Parqueadero </option>
                <option value=""></option>
                {parkings.map((parking) => (
                  <option key={parking.id} value={parking.id}> {parking.name} </option>
                ))}
            </select>

            <input type="date" id="statistics-startDate" value={startDate} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setStartDate(e.target.value)}></input>
            
            <input type="date" id="statistics-endDate" value={endDate} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setEndDate(e.target.value)}></input>
          </section>

          <section>
            <div className="bg-white p-6 rounded-md shadow-md">

              <div className="w-full border rounded-md overflow-hidden">
                  {renderSelectedGraph()}
              </div>
            </div>
          </section>        
          <section className="mt-6 flex justify-end">
                <div className="">
                <button onClick={GenPDF} className='shadow-xl px-16 py-3 mr-6 bg-blue-dark hover:bg-blue-darkest rounded-xl text-white font-title font-semibold'> Generar PDF </button>
                <button className='shadow-xl px-16 py-3 bg-blue-dark hover:bg-blue-darkest rounded-xl text-white font-title font-semibold'> Generar Excel </button>
                
                </div>

          </section>
        </section>
    </>
  )
}

export default StatisticsPage