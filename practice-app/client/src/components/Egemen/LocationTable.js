import {Button, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow} from "@mui/material";
import {useState} from "react";
import TextField from "@mui/material/TextField";
import {fetchRecords} from "../../queries/egemen.query";

const helperTextDefault = "Enter the title of records you want to receive";
const LocationTable = () => {

    const [recordsTitle, setRecordsTitle] = useState("");
    const [records, setRecords] = useState([]);
    const [helperText, setHelperText] = useState(helperTextDefault);

    const handleGetRecords = async (e) => {
        e.preventDefault();
        // setRecords(await fetchRecords(recordsTitle));
        const newRecords = await fetchRecords(recordsTitle)
        setRecords(newRecords);
        setHelperText(newRecords.length + " results returned.");
    };

    const handleRecordsTitleChange = (e) => {
        setRecordsTitle(e.target.value);
    };

    return (
        <div>
            <form onSubmit={handleGetRecords}
                  style={{display: 'flex', flexDirection: 'row', columnGap: '10px'}}>
                <TextField
                    required
                    label="Records Title"
                    value={recordsTitle}
                    inputProps={{maxLength: 60}}
                    onChange={handleRecordsTitleChange}
                    helperText={helperText}
                />
                <Button
                    variant='contained' color='primary' type='submit' onSubmit={handleGetRecords}
                    style={{ alignSelf: 'center' }}
                >
                    Get Records
                </Button>
            </form>
            <TableContainer component={Paper}>
                <Table sx={{minWidth: 650}} aria-label="simple table">
                    <TableHead>
                        <TableRow>
                            <TableCell>Address</TableCell>
                            <TableCell align="right">Latitude</TableCell>
                            <TableCell align="right">Longitude</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {records.map((record) => (
                            <TableRow
                                key={record.id}
                            >
                                <TableCell component="th" scope="row">
                                    {record.address}
                                </TableCell>
                                <TableCell align="right">{record.latitude}</TableCell>
                                <TableCell align="right">{record.longitude}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </div>
    );
}

export default LocationTable;
