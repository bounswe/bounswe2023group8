import React, { useState } from "react";
import { fetchLocationInfo, fetchForecastInfo, saveForecast } from "../../queries/meric.query";
import TextField from "@mui/material/TextField";
import { Button, MenuItem } from "@mui/material";

function ForecastSearch() {

    const [searchText, setSearchText] = useState("")
    const [options, setOptions] = useState([]);
    const [selectedOption, setSelectedOption]= useState({});

    const handleInputChange = async (e) => {

        console.log(e.target.value);
        const newInput = e.target.value;
        setSearchText(newInput);
        const locationInfo = await fetchLocationInfo((newInput));
        setOptions(locationInfo);

    }

    const handleSelect = async (e) => {

        setSelectedOption(options.find((option) => option.key === e.target.value));

    }

    const handleSubmit = async (e) => {

        e.preventDefault();
        const forecastInfo = await fetchForecastInfo((selectedOption.key));
        const status = await saveForecast(selectedOption.city, selectedOption.country, forecastInfo[0].high, forecastInfo[0].low, new Date());

    }

    return (
        <form
            style={{ display: 'flex', flexDirection: 'column', justifyContent: 'space-evenly' }}
            onSubmit={handleSubmit}
        >
            <TextField
                style={{ marginBottom: "20px" }}
                label="Search"
                value={searchText}
                onChange={handleInputChange}
                helperText={"Search a location to save."}/>
            <TextField
                select
                required
                label="Options"
                value={selectedOption.key}
                onChange={handleSelect}
                helperText="* Required. Select one of the locations."
            >
                {options.map((option) => (
                    <MenuItem key={option.key} value={option.key}>
                        {option.city + ", " + option.country}
                    </MenuItem>
                ))}
            </TextField>
            {
                <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
                    <Button variant='contained' color='primary' type='submit'>Submit</Button>
                </div>
            }
        </form>
    );

}

export default ForecastSearch;