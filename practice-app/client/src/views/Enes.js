import React, { useState } from 'react';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import { useMarketSearch, addStarStock, useGetStarStocks } from '../queries/enes.query';

function Enes() {
    const [searchMarketQuery, searchInput, setSearchInput] = useMarketSearch();
    const [isStockAdded, setIsStockAdded] = useState(false);
    const { data: starStocks } = useGetStarStocks(1);

    const handleAddToStars = async (stock) => {
        if (stock.trim() === '') {
            console.error('You did not enter a stock!');
            return;
        }

        if (starStocks && starStocks.some((starStock) => starStock.stock === stock)) {
            console.error('Stock already added to stars!');
            return;
        }

        try {
            await addStarStock(1, stock, '');
            setIsStockAdded(true);
        } catch (error) {
            console.error('Error while adding star stock:', error);
        }
    };

    return (
        <div>
            <TextField
                id="outlined-controlled"
                label="Search"
                value={searchInput}
                onChange={(event) => {
                    setSearchInput(event.target.value);
                    setIsStockAdded(false);
                }}
            />
            <Button variant="contained" onClick={() => handleAddToStars(searchInput)}>
                Add to Stars
            </Button>
            {searchMarketQuery.isError && searchInput && (
                <div style={{ fontWeight: 'bold', color: 'red' }}>
                    {searchMarketQuery.error.message}
                </div>
            )}
            {searchMarketQuery.isSuccess &&
                searchMarketQuery.data &&
                !searchMarketQuery.data.title &&
                searchMarketQuery.data.map((result) => {
                    return result.value.map((value) => {
                        return (
                            <div>
                                {value.definitions.map((definition, index) => {
                                    return <div>{"Value #" + index + ": "}{definition.definition}</div>;
                                })}
                            </div>
                        );
                    });
                })}
            {isStockAdded && <div style={{ fontWeight: 'bold', color: 'green' }}>Stock added to stars!</div>}
            <h2>Star Stocks</h2>
            {starStocks && starStocks.map((stock) => (
                <div key={stock.id}>
                    <div>{stock.stock}</div>
                    <div>{stock.value}</div>
                </div>
            ))}
        </div>
    );
}

export default Enes;
