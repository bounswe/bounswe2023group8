import {AxiosInstance} from "axios";
import {useMutation} from "react-query";


export type getSpotVotesProps = {
    id: string;
    axiosInstance: AxiosInstance;
};

const getSpotVotes = async ({axiosInstance, id}: getSpotVotesProps) =>{
    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/${id}/votes`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

export const useGetSpotVotes = (props: {}) => {
    return useMutation(getSpotVotes, props);
};

export type upvoteSpotProps = {
    id: string;
    axiosInstance: AxiosInstance;
}

const upvoteSpot = async ({ axiosInstance, id }: upvoteSpotProps) => {
    const params = new URLSearchParams({
        id: id
    }).toString();

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/upvote?${params}`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

type useUpvoteSpotPros = {
    config?: any;
}
export const useUpvoteSpot = (props: useUpvoteSpotPros) => {
    const {config} = props;
    return useMutation(upvoteSpot, config);
};

export type downvoteSpotProps = {
    id: string;
    axiosInstance: AxiosInstance;
}

const downvoteSpot = async ({ axiosInstance, id }: upvoteSpotProps) => {
    const params = new URLSearchParams({
        id: id
    }).toString();

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/downvote?${params}`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

type useDownvoteSpotPros = {
    config?: any;
}

export const useDownvoteSpot = (props: useDownvoteSpotPros) => {
    const {config} = props;
    return useMutation(downvoteSpot, config);
};

export type unvoteSpotProps = {
    id: string;
    axiosInstance: AxiosInstance;
}

const unvoteSpot = async ({ axiosInstance, id }: upvoteSpotProps) => {
    const params = new URLSearchParams({
        id: id
    }).toString();

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/unvote?${params}`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

type useUnvoteSpotPros = {
    config?: any;
}

export const useUnvoteSpot = (props: useUnvoteSpotPros) => {
    const {config} = props;
    return useMutation(unvoteSpot, config);
};
