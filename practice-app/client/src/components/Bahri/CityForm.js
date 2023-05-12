import React, { useState } from "react";
import axios from "axios";
import CityList from "./CityData";

const CityForm = () => {
  const [minPopulation, setMinPopulation] = useState("");
  const [maxPopulation, setMaxPopulation] = useState("");
  const [limit, setLimit] = useState("");
  const [data, setData] = useState([]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const requestData = {
      minPopulation,
      maxPopulation,
      limit,
    };

    axios({
      method: "GET",
      url: "https://wft-geo-db.p.rapidapi.com/v1/geo/cities",
      headers: {
        "X-RapidAPI-Key": "34ef4154b4mshc0926ab382ed3c5p180f4ejsn4c1475ef464d",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com",
      },
      params: requestData,
    })
      .then((response) => {
        setData(response.data.data);
      })
      .catch((error) => {
        console.error(error);
      });
  };

  return (
    <>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="minPopulation">Min Population:</label>
          <input
            type="number"
            className="form-control"
            id="minPopulation"
            value={minPopulation}
            onChange={(e) => setMinPopulation(e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="maxPopulation">Max Population:</label>
          <input
            type="number"
            className="form-control"
            id="maxPopulation"
            value={maxPopulation}
            onChange={(e) => setMaxPopulation(e.target.value)}
          />
        </div>
        <div className="form-group">
          <label htmlFor="limit">Limit:</label>
          <input
            type="number"
            className="form-control"
            id="limit"
            value={limit}
            onChange={(e) => setLimit(e.target.value)}
          />
        </div>
        <button type="submit" className="btn btn-primary">
          Submit
        </button>
      </form>
      {data.length > 0 && <CityList data={data} />}
    </>
  );
};

export default CityForm;
