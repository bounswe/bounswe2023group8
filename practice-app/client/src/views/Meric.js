import React from 'react';
import {fetchLocationInfo} from "../queries/meric.query";
import {fetchForecastInfo} from "../queries/meric.query";

function Meric() {

    console.log(fetchLocationInfo("Paris", "ABsfBiUE2qMGA60iuC9Mckt4fBhTXTqD"));
    console.log(fetchForecastInfo("34", "ABsfBiUE2qMGA60iuC9Mckt4fBhTXTqD"));

    return (
        <div>
            Meric
        </div>
    );
}

export default Meric;
