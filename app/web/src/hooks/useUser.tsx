//
// GET USER
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";

export type GetUserProps = {
  axiosInstance: AxiosInstance;
  userId: number;
};

const getUser = async ({ axiosInstance, userId }: GetUserProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/user?id=${encodeURIComponent(
      userId
    )}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetUserProps = GetUserProps & {
  config?: any;
};

export const useGetUser = (props: useGetUserProps) => {
  const { config, ...data } = props;
  return useMutation(getUser, {
    ...config,
    variables: data,
  });
};
