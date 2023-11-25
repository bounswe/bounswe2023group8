import {Dispatch, SetStateAction, useEffect, useState} from 'react';
import {GoogleMap, MarkerF, useLoadScript,} from "@react-google-maps/api";
import React, {useMemo} from "react";
import {
    FormSelect,
    Modal
} from "react-bootstrap";
import useGetAddressList from "../../hooks/useGeolocation";

type LocationPickerProps = {
    showLocationPickerModal: boolean;
    setShowLocationPickerModal: React.Dispatch<React.SetStateAction<boolean>>;
    locationFormData: { address: string; latitude: number; longitude: number; locationSelected: boolean; };
    setLocationFormData: Dispatch<SetStateAction<{
        address: string;
        latitude: number;
        longitude: number;
        locationSelected: boolean;
    }>>;
};

export type SelectedLocationFormData = {
    latitude: number,
    longitude: number,
    address: string,
    locationSelected: boolean,
};

export type GetAddressListFormData = {
    latitude: number,
    longitude: number
}

const LocationPicker = ({
                            setShowLocationPickerModal,
                            showLocationPickerModal,
                            locationFormData,
                            setLocationFormData
                        }: LocationPickerProps) => {
    const {isLoaded} = useLoadScript({
        googleMapsApiKey: process.env.REACT_APP_GOOGLE_MAPS_API_KEY || "",
    });

    const onSubmit = async () => {
        try {
            const data = possibleLocations[addressToSubmit];
            const selected = data !== ""
            setLocationFormData({
                address: data,
                latitude: location.latitude,
                longitude: location.longitude,
                locationSelected: selected
            })
            setShowLocationPickerModal(!showLocationPickerModal);
        } catch (error) {
            console.error("Location could not be submitted");
        }
    }

    const [location, setLocation] = useState({
        latitude: locationFormData.latitude,
        longitude: locationFormData.longitude
    })
    const [possibleLocations, setPossibleLocations] = useState([""]);
    const [addressToSubmit, setAddressToSubmit] = useState(0);

    const center = useMemo(() => ({
        lat: locationFormData.latitude,
        lng: locationFormData.longitude
    }), [locationFormData]);
    const [mapRef, setMapRef] = useState();

    const onMapLoad = async (map: any) => {
        setMapRef(map);
    };

    useEffect(() => {
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-expect-error
        mapRef?.panTo({lat: location.latitude, lng: location.longitude})
    }, [location])

    const {mutate} = useGetAddressList({
        config: {
            onSuccess: (data: any) => {
                // eslint-disable-next-line @typescript-eslint/ban-ts-comment
                // @ts-expect-error
                const tempList = [...new Set(data.results.map(element => element.formatted_address))]
                setPossibleLocations(tempList);
                setAddressToSubmit(0);
            }
        }
    });
    const getAddresses = (location: { latitude: number, longitude: number }) => {
        mutate({
            ...location,
        });

    };

    const onMapClick = async (e: google.maps.MapMouseEvent) => {
        const newLocation = {latitude: e.latLng ? e.latLng.lat() : 0, longitude: e.latLng ? e.latLng.lng() : 0};
        setLocation(newLocation);
        await getAddresses(newLocation);
    };

    return (
        <Modal
            className="rounded-5"
            show={showLocationPickerModal}
            onHide={() => setShowLocationPickerModal(!showLocationPickerModal)}
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
                        <h2
                            className="card-title text-center my-3 fw-bolder"
                            style={{color: "#324ca8"}}
                        >
                            Pick the location
                        </h2>


                        <div className="mb-2">
                            <FormSelect>
                                {possibleLocations.map((possibleLocation, index) => {
                                    if (index == addressToSubmit)
                                        return <option selected key={index} onClick={() => {
                                            setAddressToSubmit(index)
                                        }}>{possibleLocation}</option>
                                    else
                                        return <option key={index} onClick={() => {
                                            setAddressToSubmit(index)
                                        }}>{possibleLocation}</option>
                                })}
                            </FormSelect>
                        </div>


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
                                    onClick={onMapClick}
                                >
                                    <MarkerF
                                        title={"You can add a new address on this location"}
                                        position={{lat: location.latitude, lng: location.longitude}}
                                    />
                                    {locationFormData.address !== "" && <MarkerF
                                        title={"Currently Selected Location"}
                                        icon={{
                                            url: "https://upload.wikimedia.org/wikipedia/commons/8/82/Ed.png?20190129231110",
                                            scaledSize: new google.maps.Size(35, 50),
                                        }}
                                        position={{lat: locationFormData.latitude, lng: locationFormData.longitude}}
                                    ></MarkerF>}
                                </GoogleMap>
                            )}

                        </div>

                        <div className="mt-2 text-center">
                            <button
                                type="button"
                                className="btn btn-primary rounded-5 fw-bolder"
                                onClick={() => onSubmit()}
                            >
                                Confirm
                            </button>
                        </div>
                    </div>
                </form>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>

    );
};

export default LocationPicker;
