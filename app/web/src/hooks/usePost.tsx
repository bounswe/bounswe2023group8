//
// CREATE POST
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import { CreatePostFormData } from "../components/Post/Create";

export type CreatePostProps = CreatePostFormData & {
  axiosInstance: AxiosInstance;
};

const createPost = async (props: CreatePostProps) => {
  const { axiosInstance, ...data } = props;

  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/create_post`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

const useCreatePost = (props: {}) => {
  return useMutation(createPost, props);
};

export default useCreatePost;
