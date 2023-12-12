import {useState} from 'react';
import {GoogleMap, MarkerF, useLoadScript,} from "@react-google-maps/api";
import React, {useMemo} from "react";
import {
    Modal
} from "react-bootstrap";

type LocationViewerProps = {
    showLocationViewerModal: boolean;
    setShowLocationViewerModal: React.Dispatch<React.SetStateAction<boolean>>;
    locationData: { address: string; latitude: number; longitude: number;};
};


const LocationViewer = ({locationData, setShowLocationViewerModal, showLocationViewerModal} :LocationViewerProps) => {
    const {isLoaded} = useLoadScript({
        googleMapsApiKey: process.env.REACT_APP_GOOGLE_MAPS_API_KEY || "",
    });


    const center = useMemo(() => ({
        lat: locationData.latitude,
        lng: locationData.longitude
    }), []);
    const [mapRef, setMapRef] = useState();

    const onMapLoad = async (map: any) => {
        setMapRef(map);
    };

    return (
        <Modal
            className="rounded-5"
            show={showLocationViewerModal}
            onHide={() => setShowLocationViewerModal(!showLocationViewerModal)}
            size="xl"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0 pt-2 pe-2 p-0 "
                closeButton
            ></Modal.Header>
            <Modal.Body className="bg-body-secondary h-100 w-100 p-0">
                <form
                    className="card-body align-items-center d-flex flex-column bg-body-secondary">
                    <div className="mb-3 d-flex flex-column "
                         style={{height: '70vh', width: '95%'}}>
                        <h6
                            className="card-title text-center my-3 fw-bolder"
                            style={{color: "#324ca8"}}
                        >
                            {locationData.address}
                        </h6>

                        <div
                            className="h-100 w-100">
                            {!isLoaded ? (
                                <h1>Loading...</h1>
                            ) : (
                                <GoogleMap
                                    mapContainerStyle={{height: '100%', width: '100%', position: 'relative'}}
                                    mapContainerClassName="map-container"
                                    center={center}
                                    zoom={10}
                                    onLoad={onMapLoad}
                                >
                                    <MarkerF
                                        title={"Currently Selected Location"}
                                        icon={{
                                            url: "https://upload.wikimedia.org/wikipedia/commons/8/82/Ed.png?20190129231110",
                                            scaledSize: new google.maps.Size(35, 50),
                                        }}
                                        position={{lat: locationData.latitude, lng: locationData.longitude}}
                                    ></MarkerF>
                                </GoogleMap>
                            )}

                        </div>
                    </div>
                </form>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>

    );
};
export default LocationViewer;
