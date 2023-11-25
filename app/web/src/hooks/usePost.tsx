//
// CREATE POST
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import {CreatePostFormData} from "../components/Post/Create/PostCreateCard";
import {SelectedLocationFormData} from "../components/Geolocation/LocationPicker";


export type CreatePostProps = CreatePostFormData & SelectedLocationFormData & {
  axiosInstance: AxiosInstance;
};

const createPost = async (props: CreatePostProps) => {
  const { axiosInstance, ...data } = props;
  console.log(data);
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/create_post`,
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
      `${process.env.REACT_APP_BACKEND_API_URL}/update_post`,
      data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useUpdatePost = (props: {}) => {
  return useMutation(updatePost, props);
}

export type getPostProps = {
  id: string
  axiosInstance: AxiosInstance;
}

const getPost = async ({axiosInstance, id}: getPostProps) => {
  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/get_post/${id}`,
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

export const useGetPost = (props: {}) => {
  return useMutation(getPost, props);
}

