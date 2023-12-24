import {AxiosInstance} from "axios";
import {useMutation} from "react-query";

export type CreateCommentProps = {
    postId: string;
    data: {
        content: string
    };
    axiosInstance: AxiosInstance;
};

const createComment = async ({axiosInstance, data, postId}: CreateCommentProps) => {

    const response = await axiosInstance.post(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/${postId}/comment`,
        data
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

type useCreateCommentProps = {
    config?: any;
}

export const useCreateComment = (props: useCreateCommentProps) => {
    const {config} = props;
    return useMutation(createComment, config);
};

export type GetCommentProps = {
    postId: string;
    axiosInstance: AxiosInstance;
}

const getComments = async({axiosInstance, postId}: GetCommentProps)=> {
    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/${postId}/comments`,
    )

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
};

export const useGetComments = (props: {}) => {
    return useMutation(getComments, props);
}

export type UpdateCommentProps = {
    postId: number;
    data: {
        commentId: number;
        content: string;
    }
    axiosInstance: AxiosInstance;
}

const updateComment = async ({axiosInstance, data, postId}: UpdateCommentProps) => {
    const response = await axiosInstance.put(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/${postId}/comment`,
        data
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

type useUpdateCommentProps = {
    config?: any;
}
export const useUpdateComment = (props: useUpdateCommentProps) => {
    const {config} = props;
    return useMutation(updateComment, config);
}

export type DeleteCommentProps = {
    postId: number;
    commentId: number;
    axiosInstance: AxiosInstance;
}

const deleteComment = async ({axiosInstance, commentId, postId}: DeleteCommentProps) => {
    const response = await axiosInstance.delete(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post/${postId}/comment/${commentId}`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

type useDeleteCommentProps = {
    config?: any;
}

export const useDeleteComment = (props: useDeleteCommentProps) => {
    const {config}= props;
    return useMutation(deleteComment, config);
}
