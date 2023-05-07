import React, {useState, useEffect} from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import { useUsersQuery , useWikiSearchOptions  } from '../queries/baki.query';


function Baki() {

    // const [usersQuery, id, setId] = useUsersQuery();
    const [options, setOptions] = useState([ ]);
    const [searchOptionsQuery, searchInput, setSearchInput] = useWikiSearchOptions();

 
    // useEffect(() => {
      

    //     console.log("usersQuery", usersQuery.data);
    //     if(usersQuery?.data?.username) {
         
    //         setOptions(  [usersQuery?.data?.username])
    //     }else{
    //         setOptions([]  );
    //     }
      
    // }, [usersQuery.data])

       useEffect(() => {
      
            
        console.log("searchOptionsQuery", searchOptionsQuery.data);
        
        setOptions(searchOptionsQuery?.data?.search ? searchOptionsQuery.data.search.map((search) => search.display.label.value + " "+ search.id) : []  );
        
    
      
    }, [searchOptionsQuery.data])


    useEffect(() => {

       console.log("options", options);

    }, [options])



    return (
        <div>
            <Autocomplete
                options={options}
                // getOptionLabel={(option) => option.label}
                renderInput={(params) => <TextField {...params} label="Search" variant="outlined" />}
                onInputChange={(event, newInputValue) => {
                    setSearchInput(newInputValue);
                }}
                inputValue={searchInput}
                clearOnBlur={false}
                filterOptions={(options, state) => { return options; }}
                />
        </div>
    );
}

export default Baki;
