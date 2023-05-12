import React from "react";
import "bootstrap/dist/css/bootstrap.css";

const CityCard = ({ city, country, population }) => {
  return (
    <div className="card">
      <div className="card-body">
        <h5 className="card-title">{city}</h5>
        <h6 className="card-subtitle mb-2 text-muted">{country}</h6>
        <p className="card-text">Population: {population}</p>
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
