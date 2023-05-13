import React, { useEffect, useState } from "react";
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import { CircularProgress } from '@mui/material';

function Bahadir() {
    const [stocks, setStocks] = useState([]);
    const [searchResults, setSearchResults] = useState([]);
    const [autoCompleteResults, setAutoCompleteResults] = useState([]);
    const [open, setOpen] = useState(false);
    const [options, setOptions] = useState([]);
    const loading = open && options.length === 0;
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedStock, setSelectedStock] = useState(null);

    const getStockBySymbol = (stockId) => {
      const options = {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json',
          },
      };

      fetch(`/api/stock/${stockId}?latest=true`, options)
          .then(response => response.json())
          .then(data => setSelectedStock(data))
          .catch(err => console.error(err));
  }

    useEffect(() => {
        fetch(`/api/stock/all`)
            .then(response => response.json())
            .then(data => setStocks(data))
            .catch(err => console.error(err));
    }, []);

    const searchStocks = (keyword) => {
        fetch(`/api/stock/search?keyword=${keyword}`)
            .then(response => response.json())
            .then(data => setSearchResults(data))
            .catch(err => console.error(err));
    }

    const autoComplete = (keyword) => {
        fetch(`/api/stock/autocomplete?keyword=${keyword}`)
            .then(response => response.json())
            .then(data => setAutoCompleteResults(data))
            .catch(err => console.error(err));
    }

    const handleSearch = (event, newValue) => {
      if(newValue === null || newValue.trim() === "") {
          setOptions([]);
          setSelectedStock(null);
      } else {
          fetch(`/api/stock/search?keyword=${newValue}`)
              .then(response => response.json())
              .then(data => {
                  if(Object.keys(data).length === 0) {
                      setSelectedStock({symbol: "Not Found", name: `No data found for ${newValue}`});
                  } else {
                      setOptions(Object.keys(data).map(key => ({symbol: key, name: data[key][0].name})));
                  }
              })
              .catch(err => console.error(err));
      }
  }

  return (
    <div>
        <Autocomplete
          id="stock-search"
          style={{ width: 300 }}
          open={open}
          onOpen={() => {
            setOpen(true);
          }}
          onClose={() => {
            setOpen(false);
          }}
          onChange={(event, newValue) => {
            if(newValue) {
              getStockBySymbol(newValue.symbol);
            }
          }}
          onInputChange={handleSearch}
          getOptionSelected={(option, value) => option.symbol === value.symbol}
          getOptionLabel={(option) => option.symbol}
          options={options}
          loading={loading}
          renderInput={(params) => (
            <TextField
              {...params}
              label="Search Stocks"
              variant="outlined"
              InputProps={{
                ...params.InputProps,
                endAdornment: (
                  <React.Fragment>
                    {loading ? <CircularProgress color="inherit" size={20} /> : null}
                    {params.InputProps.endAdornment}
                  </React.Fragment>
                ),
              }}
            />
          )}
        />
        {selectedStock && (
            <div>
                <h2>{selectedStock.symbol}</h2>
                {selectedStock.symbol === "Not Found" ? 
                  <p>{selectedStock.name}</p> :
                  <div>
                    <p>Trading Day: {selectedStock.tradingDay}</p>
                    <p>Open: {selectedStock.open}</p>
                    <p>High: {selectedStock.high}</p>
                    <p>Low: {selectedStock.low}</p>
                    <p>Close: {selectedStock.close}</p>
                    <p>Price: {selectedStock.price}</p>
                    <p>Volume: {selectedStock.volume}</p>
                      <button onClick={() => getStockBySymbol(selectedStock.symbol)}>Update</button>
                    </div>
                  }
              </div>
          )}
      </div>
    );
}

export default Bahadir;
