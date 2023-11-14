import {Dispatch, SetStateAction, useEffect, useState} from 'react';
import {GoogleMap, MarkerF, useLoadScript,} from "@react-google-maps/api";
import React, {useMemo} from "react";
import {useForm, SubmitHandler} from "react-hook-form";
import {
    FormSelect,
    Modal
} from "react-bootstrap";
import useGetAddressList from "../../hooks/useGeolocation";

type LocationPickerProps = {
    showLocationPickerModal: boolean;
    handleShowLocationPickerModal: () => void;
    setLocationFormData: Dispatch<SetStateAction<{ address: string; latitude: number; longitude: number; }>>;
};

export type SelectedLocationFormData = {
    latitude: number,
    longitude: number,
    address: string
};

export type GetAddressListFormData = {
    latitude: number,
    longitude: number
}

const LocationPicker = ({
                            handleShowLocationPickerModal,
                            showLocationPickerModal,
                            setLocationFormData
                        }: LocationPickerProps) => {
    const {isLoaded} = useLoadScript({
        googleMapsApiKey: process.env.REACT_APP_GOOGLE_MAPS_API_KEY || "",
    });

    const {
        register,
        handleSubmit,
        formState: {errors}
    } = useForm<SelectedLocationFormData>();

    const onSubmit: SubmitHandler<SelectedLocationFormData> = async (data) => {
        try {
            setLocationFormData({address: data.address, latitude: location.latitude, longitude: location.longitude})
            handleShowLocationPickerModal();
        } catch (error) {
            console.error("Location could not be submitted");
        }
    }

    const [location, setLocation] = useState({latitude: 41, longitude: 29})
    const [possibleLocations, setPossibleLocations] = useState([""]);
    const [addressToSubmit, setAddressToSubmit] = useState(0);
    const center = useMemo(() => ({lat: location.latitude, lng: location.longitude}), []);
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
            onHide={handleShowLocationPickerModal}
            size="xl"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0 pt-2 pe-2 p-0 "
                closeButton
            ></Modal.Header>
            <Modal.Body className="bg-body-secondary h-100 w-100 p-0">
                <form onSubmit={handleSubmit(onSubmit)}
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
                            <FormSelect className="form-control"
                                        {...register("address", {
                                            required: "This field is required",
                                        })}>
                                {["Select an Address", ...possibleLocations].map((possibleLocation, index) => {
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
                            {errors.address && (
                                <span className="text-danger">{errors.address.message}</span>
                            )}
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
                                        position={{lat: location.latitude, lng: location.longitude}}
                                    />
                                </GoogleMap>
                            )}
                        </div>

                        <div className="mt-2 text-center">
                            <button
                                type="submit"
                                className="btn btn-primary rounded-5 fw-bolder"
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
