import React from 'react';
import { fetchLocationInfo, fetchForecastInfo } from "../queries/meric.query";
import ForecastSearch from "../components/Meric/ForecastSearch";
import SavedLocations from "../components/Meric/SavedLocations";

function Meric() {

    return (
        <div>
            <ForecastSearch/>
            <SavedLocations/>
        </div>
    );
}

export default Meric;
