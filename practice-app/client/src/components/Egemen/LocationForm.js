import { useState } from "react";
import {TextField, Button, MenuItem} from "@mui/material";
import PropTypes, {string} from "prop-types";
import {addNewAddress, getNumberOfLocationsForTitle} from "../../queries/egemen.query";

const [defaultTitleHelperText, limitReachedHelperText] =
  [
    "* Required. Enter a title to save this location under. A title can hold up to 30 addresses",
    "This title cannot hold more addresses"
  ];
const addressLimitPerTitle = 3;


const LocationForm = ({ location, setLocation,
                        title, setTitle,
                        address, setAddress,
                        availableAddresses, setAvailableAddresses
                      }) => {



  const [submitted, setSubmitted] = useState(false);
  const [titleHelperText, setTitleHelperText] = useState(defaultTitleHelperText);
  const [limitReached, setLimitReached] = useState(false);


  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!submitted) {
      //TODO Submit data to the database
      const status = await addNewAddress(location.lat, location.lng, address, title);
      //if successful
      setSubmitted(true);
      // if not successful warn the user somehow?
    }
  };

  const handleReset = async (e) => {
    e.preventDefault();
    await checkTitleForAddressLimit(title);
    setLocation({lat: 41.015137, lng: 28.979530});
    setAddress("");
    setAvailableAddresses([]);
    setSubmitted(false);
  }

  const handleTitleChange = async (e) => {
    const newTitle = e.target.value
    setTitle(newTitle);
    await checkTitleForAddressLimit(newTitle);
  };

  const checkTitleForAddressLimit = async (titleToCheck) => {
    const count = await getNumberOfLocationsForTitle(titleToCheck);
    if (count >= addressLimitPerTitle) {
      setLimitReached(true);
      setTitleHelperText(limitReachedHelperText);
    } else {
      setLimitReached(false);
      setTitleHelperText(defaultTitleHelperText);
    }
  };

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
          inputProps={{ maxLength: 60 }}
          onChange={handleTitleChange}
          helperText={titleHelperText}/>
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
            !limitReached
              ?
              <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
                <Button variant='contained' color='secondary' type='reset'>Reset</Button>
                <Button variant='contained' color='primary' type='submit'>Submit</Button>
              </div>
              :
              <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
                <Button variant='contained' color='secondary' type='reset'>Reset</Button>
                <Button disabled variant='contained' color='primary' type='submit'>Limit Reached</Button>
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
