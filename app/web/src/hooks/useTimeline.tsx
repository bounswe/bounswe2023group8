import {AxiosInstance} from "axios";
import {useMutation} from "react-query";

export type GetUserTimelineProps = {
    axiosInstance: AxiosInstance;
}

const getUserTimeline = async ({axiosInstance} : GetUserTimelineProps) => {
    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/home`
    )
    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

export const useGetUserTimeline = (props: {}) => {
    return useMutation(getUserTimeline, props);
}
