import { useState } from "react";
import {TextField, Button, MenuItem} from "@mui/material";
import PropTypes, {string} from "prop-types";


const LocationForm = ({ location, setLocation,
                        title, setTitle,
                        address, setAddress,
                        availableAddresses, setAvailableAddresses
                      }) => {

  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if(!submitted){
      //TODO Submit data to the database
      console.log("Title: " + title);
      console.log("latitude: " + location.lat + ", longitude: " + location.lng);
      console.log("Address: " + address);
      //if successful
      setSubmitted(true);
      // if not successful warn the user somehow?
    }
  };

  const handleReset = (e) => {
    e.preventDefault();
    setLocation({ lat: 41.015137, lng: 28.979530 });
    setAddress("");
    setAvailableAddresses([]);
    setSubmitted(false);
  }

  return (
      <form
        style={{  display: 'flex', flexDirection: 'column', justifyContent: 'space-evenly'}}
        onSubmit={handleSubmit}
        onReset={handleReset}
      >
        <TextField
          required
          label="Title"
          value={title}
          onChange={e => setTitle(e.target.value)}
          helperText="* Required. Enter a title to save this location under. A title can hold more than one address."/>
        <TextField
          select
          required
          label="Address"
          value={address}
          onChange={e => setAddress(e.target.value)}
          helperText="* Required. Select one of the addresses available to the marker you placed."
        >
          {availableAddresses.map((option) => (
            <MenuItem key={option} value={option}>
              {option}
            </MenuItem>
          ))}
        </TextField>
        {
          !submitted
            ?
            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
              <Button variant='contained' color='secondary' type='reset'>Reset</Button>
              <Button variant='contained' color='primary' type='submit'>Submit</Button>
            </div>
            :
            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
              <Button variant='contained' color='secondary' type='reset'>Add a new location</Button>
              <Button disabled variant='contained' color='primary' type='submit'>Submitted</Button>
            </div>
        }
      </form>
  );
};

LocationForm.propTypes = {
  location: PropTypes.shape({
    lat: PropTypes.number.isRequired,
    lng: PropTypes.number.isRequired,
  }),
  setLocation: PropTypes.func.isRequired,
  address: PropTypes.string.isRequired,
  setAddress: PropTypes.func.isRequired,
  title: PropTypes.string.isRequired,
  setTitle: PropTypes.func.isRequired,
  availableAddresses: PropTypes.arrayOf(string).isRequired,
  setAvailableAddresses: PropTypes.func.isRequired,
}

export default LocationForm;
