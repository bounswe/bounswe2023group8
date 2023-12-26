//
// CREATE POST
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import { CreatePostRequestData } from "../components/Post/Create/PostCreateCard";
import {useNavigate} from "react-router-dom";

export type CreatePostProps = CreatePostRequestData & {
    geoLocation: {
      latitude: number,
      longitude: number,
      address: string,
    }
    axiosInstance: AxiosInstance;
  };

const createPost = async (props: CreatePostProps) => {
  const { axiosInstance, ...data } = props;
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/post`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useCreatePost = (props: {}) => {
  const navigate = useNavigate();
  return useMutation(createPost, {
    ...props,
    onSuccess: (data: any) => navigate(`/interest-area/${data.interestAreaId}`)});
};

export type UpdatePostsProps = CreatePostRequestData & {
  geoLocation: {
    latitude: number,
    longitude: number,
    address: string,
  };
  axiosInstance: AxiosInstance;
  id: string;
};

const updatePost = async (props: UpdatePostsProps) => {
  const { axiosInstance, id,...data} = props;
  const params = new URLSearchParams({
    id: id
  })
  const response = await axiosInstance.put(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/post?${params}`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useUpdatePost = (props: {}) => {
  const navigate = useNavigate();
  return useMutation(updatePost,{
    ...props,
    onSuccess: (data: any) => navigate(`/posts/${data.id}`)});
};

export type getPostProps = {
  id: string;
  axiosInstance: AxiosInstance;
};

const getPost = async ({ axiosInstance, id }: getPostProps) => {
  const params = new URLSearchParams({
    id: id
  }).toString();

  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/post?${params}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useGetPost = (props: {}) => {
  return useMutation(getPost, props);
};

export type deletePostProps = {
  id: string;
  axiosInstance: AxiosInstance
}

const deletePost = async ({axiosInstance, id}: deletePostProps)=> {
    const params = new URLSearchParams({
        id: id
    }).toString();
    const response = await axiosInstance.delete(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/post?${params}`
    );

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

type useDeletePostProps = {
    config?: any
}

export const useDeletePost = (props: useDeletePostProps) => {
    const {config} = props;
    return useMutation(deletePost, config);
}