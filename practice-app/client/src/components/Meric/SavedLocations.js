import { Button, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow } from "@mui/material";
import { useState } from "react";
import { getSavedForecasts } from "../../queries/meric.query"

const LocationTable = () => {

    const [forecasts, setForecasts] = useState([]);

    const handleGetForecasts = async (e) => {

        e.preventDefault();
        const newForecasts = await getSavedForecasts()
        setForecasts(newForecasts);

    };

    return (
        <div>
            <form
                onSubmit={handleGetForecasts}
                style={{display: 'flex', flexDirection: 'row', columnGap: '10px'}}
            >
                <Button
                    variant='contained' color='primary' type='submit' onSubmit={handleGetForecasts}
                    style={{ alignSelf: 'center' }}
                >
                    Get Records
                </Button>
            </form>
            <TableContainer component={Paper}>
                <Table sx={{minWidth: 650}} aria-label="simple table">
                    <TableHead>
                        <TableRow>
                            <TableCell>City</TableCell>
                            <TableCell align="right">Country</TableCell>
                            <TableCell align="right">High</TableCell>
                            <TableCell align="right">Low</TableCell>
                            <TableCell align="right">Date</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {forecasts?.map((forecast) => (
                            <TableRow
                                key={forecast.id}
                            >
                                <TableCell component="th" scope="row">
                                    {forecast.city}
                                </TableCell>
                                <TableCell align="right">{forecast.country}</TableCell>
                                <TableCell align="right">{forecast.high}</TableCell>
                                <TableCell align="right">{forecast.low}</TableCell>
                                <TableCell align="right">{forecast.date}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </div>
    );
}

export default LocationTable;
