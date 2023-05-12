import React from 'react';
import { fetchLocationInfo, fetchForecastInfo } from "../queries/meric.query";
import ForecastSearch from "../components/Meric/ForecastSearch";

function Meric() {

    console.log(fetchLocationInfo("Paris", "ABsfBiUE2qMGA60iuC9Mckt4fBhTXTqD"));
    console.log(fetchForecastInfo("34", "ABsfBiUE2qMGA60iuC9Mckt4fBhTXTqD"));

    return (
        <div>
            <ForecastSearch

            />
        </div>
    );
}

export default Meric;
