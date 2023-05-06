import React, {useState} from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';


function Baki() {

    const [options, setOptions] = useState([]);

    const handleInputChange = async (event, value) => {
        // You can send a request to your API here and update the options state accordingly
        const response = await fetch(`https://www.wikidata.org/w/api.php?action=wbsearchentities&format=json&search=${value}&language=en&uselang=en&type=item)`);
        const data = await response.json();
        console.log("data", data);
        setOptions(data.search.map((item) => ({label: item.id, value: item.id})));
    };
    return (
        <div>
            <Autocomplete
                options={options}
                getOptionLabel={(option) => option.label}
                renderInput={(params) => <TextField {...params} label="Search" variant="outlined" />}
                onInputChange={handleInputChange}
                />
        </div>
    );
}

export default Baki;
