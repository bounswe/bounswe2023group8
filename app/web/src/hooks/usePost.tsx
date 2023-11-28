//
// CREATE POST
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import { CreatePostRequestData } from "../components/Post/Create/PostCreateCard";

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
  console.log(data);
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/post`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useCreatePost = (props: {}) => {
  return useMutation(createPost, props);
};

const updatePost = async (props: CreatePostProps) => {
  const { axiosInstance, ...data } = props;
  console.log(data);
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/update_post`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useUpdatePost = (props: {}) => {
  return useMutation(updatePost, props);
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
