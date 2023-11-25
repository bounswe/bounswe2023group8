import axios from "axios";
import { useMutation } from "react-query";
import {GetAddressListFormData} from "../components/Geolocation/LocationPicker";

export type GetAddressListProps = GetAddressListFormData;

const getAddressList = async ({ latitude, longitude}: GetAddressListProps) => {
    const axiosInstance = axios.create({
        baseURL: process.env.REACT_APP_GOOGLE_MAPS_API_URL,
    });

    const response = await axiosInstance.post(
        `geocode/json?latlng=${latitude},${longitude}&key=${process.env.REACT_APP_GOOGLE_MAPS_API_KEY}`,
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

type UseGetAddressListProps = {
    config?: any
};

const useGetAddressList = (props: UseGetAddressListProps) => {
    const { config } = props;
    return useMutation(getAddressList, config);
};

export default useGetAddressList;
