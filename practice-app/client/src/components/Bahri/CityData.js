import React from "react";
import "bootstrap/dist/css/bootstrap.css";
import axios from "axios";

const CityCard = ({ city, country, population }) => {
  const saveCity = (name, country, population) => {
    const city = {
      name: name,
      country: country,
      population: population,
    };

    axios
      .post(`/api/city`, city, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        window.location.reload();
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return (
    <div className="card">
      <div className="card-body">
        <h5 className="card-title">{city}</h5>
        <h6 className="card-subtitle mb-2 text-muted">{country}</h6>
        <p className="card-text">Population: {population}</p>
        <button
          className="btn btn-primary"
          onClick={() => saveCity(city, country, population)}
        >
          Save City
        </button>
      </div>
    </div>
  );
};

const CityList = ({ data }) => {
  if (!Array.isArray(data)) {
    return <div>Error: Invalid data format!</div>;
  }
  return (
    <div className="container">
      <div className="row">
        {data.map((city) => {
          const { id, city: cityName, country, population } = city;
          return (
            <div className="col-md-4 mb-4" key={id}>
              <CityCard
                city={cityName}
                country={country}
                population={population}
              />
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default CityList;
export { CityCard };
