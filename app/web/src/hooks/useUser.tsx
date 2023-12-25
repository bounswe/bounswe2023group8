//
// GET USER
//

import { AxiosInstance } from "axios";
import { useMutation, useQuery } from "react-query";

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

//
// GET WAITING BUNCH FOLLOW REQUESTS
//

export type GetWaitingBunchFollowRequestsProps = {
  axiosInstance: AxiosInstance;
};

const getWaitingBunchFollowRequests = async ({
  axiosInstance,
}: GetWaitingBunchFollowRequestsProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/interest-area-follow-requests`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetWaitingBunchFollowRequestsProps =
  GetWaitingBunchFollowRequestsProps & {
    config?: any;
  };

export const useGetWaitingBunchFollowRequests = (
  props: useGetWaitingBunchFollowRequestsProps
) => {
  const { axiosInstance, config } = props;
  return useQuery(
    ["getWaitingBunchFollowRequests"],
    () => getWaitingBunchFollowRequests({ axiosInstance }),
    config
  );
};

//
//  GET FOLLOWING INTEREST AREAS OF USER
//

export type GetUserFollowingInterestAreasProps = {
  axiosInstance: AxiosInstance;
  id: number;
};

const getUserFollowingInterestAreas = async (
  props: GetUserFollowingInterestAreasProps
) => {
  const { axiosInstance, id } = props;
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/${id}/interest-areas`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetUserFollowingInterestAreasProps =
  GetUserFollowingInterestAreasProps & {
    config?: any;
  };

export const useGetUserFollowingInterestAreas = (
  props: useGetUserFollowingInterestAreasProps
) => {
  const { id, config } = props;
  return useQuery(
    ["getUserFollowingInterestAreas", id],
    () => getUserFollowingInterestAreas(props),
    config
  );
};
