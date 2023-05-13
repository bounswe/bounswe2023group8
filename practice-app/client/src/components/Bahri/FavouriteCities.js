import React, { useState, useEffect } from "react";
import "bootstrap/dist/css/bootstrap.css";
import axios from "axios";

const FavouriteCityCard = ({ city, country, population }) => {
  return (
    <div className="card">
      <div className="card-body">
        <p className="card-text">Population: {population}</p>
        <p className="card-text">Country: {country}</p>
        <p className="card-text">City: {city}</p>
      </div>
    </div>
  );
};

const FavouriteCities = () => {
  const getSavedCities = () => {
    axios.get(`/api/city`).then((response) => {
      setFavouriteCities(response.data);
    });
  };

  const [favouriteCities, setFavouriteCities] = useState([]);
  useEffect(() => {
    getSavedCities();
  }, []);

  return (
    <div className="container">
      <div className="row">
        <h1 className="text-center">Favourite Cities</h1>
        {favouriteCities.map((city) => {
          const { id, name, country, population } = city;
          return (
            <div className="col-md-4 mb-4" key={id}>
              <FavouriteCityCard
                city={name}
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

export default FavouriteCities;
