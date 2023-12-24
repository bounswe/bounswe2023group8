import { AxiosInstance } from "axios";
import { useMutation, useQuery } from "react-query";

export type GetUserProfileProps = {
  axiosInstance: AxiosInstance;
  userId: string;
};

const getUserProfile = async ({
  axiosInstance,
  userId,
}: GetUserProfileProps) => {
  const params = new URLSearchParams({
    id: userId,
  }).toString();

  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/profile?${params}`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useGetUserProfile = (props: {}) => {
  return useMutation(getUserProfile, props);
};

export type GetUserFollowingInterestAreasProps = {
  axiosInstance: AxiosInstance;
  userId: string;
};

const getUserFollowingInterestAreas = async (
  props: GetUserFollowingInterestAreasProps
) => {
  const { axiosInstance, userId } = props;
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/${userId}/interest-areas`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useGetUserFollowingInterestAreas = (props: {}) => {
  return useMutation(getUserFollowingInterestAreas, props);
};

export type GetUserPostsProps = {
  axiosInstance: AxiosInstance;
  userId: string;
};

const getUserPosts = async (props: GetUserFollowingInterestAreasProps) => {
  const { axiosInstance, userId } = props;
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/${userId}/posts`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useGetUserPosts = (props: {}) => {
  return useMutation(getUserPosts, props);
};

export type GetUserReputationProps = {
  axiosInstance: AxiosInstance;
  userId: string;
};

const getUserReputation = async ({
  axiosInstance,
  userId,
}: GetUserReputationProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/reputation/badges?enigmaUserId=${userId}`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useGetUserReputation = (props: GetUserReputationProps) => {
  return useQuery(["userReputation", props.userId], () =>
    getUserReputation(props)
  );
};
