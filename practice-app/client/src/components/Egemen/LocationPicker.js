import {useEffect, useState} from 'react';
import PropTypes, {string} from 'prop-types';
import { GoogleMap, MarkerF, useLoadScript } from "@react-google-maps/api";
import { useMemo } from "react";
import {fetchAddresses} from "../../queries/egemen.query";

const LocationPicker = ({ location, setLocation,
                          setAvailableAddresses}) => {
  const { isLoaded } = useLoadScript({
    googleMapsApiKey: process.env.REACT_APP_GOOGLE_MAPS_API_KEY,
  });
  const center = useMemo(() => ({ lat: location.lat, lng: location.lng}), []);
  const [mapRef, setMapRef] = useState();

  const onMapLoad = async (map) => {
    setMapRef(map);
    setAvailableAddresses(await fetchAddresses(location.lat, location.lng));
  };

  useEffect(() => (mapRef?.panTo({ lat: location.lat, lng: location.lng })), [location])

  const onMapClick = async (e) => {
    const newLocation = {lat: e.latLng.lat(), lng: e.latLng.lng()};
    setLocation(newLocation);
    setAvailableAddresses(await fetchAddresses(newLocation.lat, newLocation.lng));
  };

  return (
    <div>
      <div style={{ height: '40vh', width: '40vw' }}>
        {!isLoaded ? (
          <h1>Loading...</h1>
        ) : (
          <GoogleMap
            mapContainerStyle={{ height: '100%', width: '100%', position: 'relative' }}
            mapContainerClassName="map-container"
            center={center}
            zoom={10}
            onLoad={onMapLoad}
            onClick={onMapClick}
          >
            <MarkerF
              position={{ lat: location.lat, lng: location.lng }}
            />
          </GoogleMap>
        )}
      </div>
    </div>
  );
};

LocationPicker.propTypes = {
  location: PropTypes.shape({
    lat: PropTypes.number.isRequired,
    lng: PropTypes.number.isRequired,
  }),
  setLocation: PropTypes.func.isRequired,
  address: PropTypes.string.isRequired,
  setAddress: PropTypes.func.isRequired,
  availableAddresses: PropTypes.arrayOf(string).isRequired,
  setAvailableAddresses: PropTypes.func.isRequired,
}

export default LocationPicker;
