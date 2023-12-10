import React, {useState} from 'react';
import {Button} from "react-bootstrap";
import LocationViewer from "../../components/Geolocation/LocationViewer";

const MapTestPage: React.FC = () => {
    const [showLocationViewerModal, setShowLocationViewerModal] = useState(false);
    const handleLocationViewerModal = () => {
        setShowLocationViewerModal(!showLocationViewerModal);
    }

    const defaultLocationDetails = {
        latitude: 40.987673250682725,
        longitude: 29.03688669204712,
        address: "Kadıköy/İstanbul, Türkiye"
    }

    return (
        <>
            <Button onClick={() => handleLocationViewerModal()}>
                Show Picker
            </Button>
            <LocationViewer
                locationData={defaultLocationDetails}
                showLocationViewerModal={showLocationViewerModal}
                setShowLocationViewerModal={handleLocationViewerModal}
            />
        </>
    );
};

export default MapTestPage;
