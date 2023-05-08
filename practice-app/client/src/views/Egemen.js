import { useState } from "react";
import LocationPicker from "../components/Egemen/LocationPicker";
import LocationForm from "../components/Egemen/LocationForm";


const Egemen = () => {

  const [location, setLocation] = useState({ lat: 41.015137, lng: 28.979530 });
  const [address, setAddress] = useState("");
  const [title, setTitle] = useState("");
  const [availableAddresses, setAvailableAddresses] = useState([""])

  return (
    <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly'}}>
      <LocationPicker
        location={location}
        setLocation={setLocation}
        address={address}
        setAddress={setAddress}
        availableAddresses={availableAddresses}
        setAvailableAddresses={setAvailableAddresses}
      />
      <LocationForm
        location={location} setLocation={setLocation}
        address={address} setAddress={setAddress}
        title={title} setTitle={setTitle}
        availableAddresses={availableAddresses}
        setAvailableAddresses={setAvailableAddresses}
      />
    </div>
  );
};

export default Egemen;
