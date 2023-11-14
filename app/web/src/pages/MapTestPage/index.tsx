import React, { useState } from 'react';
import LocationPicker from "../../components/Geolocation/LocationPicker";
import {Button} from "react-bootstrap";

const MapTestPage: React.FC = () => {
    const [showLocationPickerModal, setShowLocationPickerModal] = useState(false);
    const [locationData, setLocationData]
        = useState({address: " ", latitude: 0, longitude:0});
   const handleLocationPickerModal = () => {
       setShowLocationPickerModal(!showLocationPickerModal);
   }

    return (
        <>
            <Button onClick={() => handleLocationPickerModal()}>
                Show Picker
            </Button>
            <LocationPicker
                setLocationFormData={setLocationData}
                showLocationPickerModal={showLocationPickerModal}
                handleShowLocationPickerModal={handleLocationPickerModal}
            />
            <div>{locationData.address}</div>
            <div>{locationData.latitude}</div>
            <div>{locationData.longitude}</div>

        </>
    );
};

export default MapTestPage;
