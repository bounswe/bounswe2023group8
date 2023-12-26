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


export type FollowUserProps = {
  axiosInstance: AxiosInstance,
  id: number;
}

const followUser = async ({axiosInstance, id}: FollowUserProps) => {
  const params = new URLSearchParams({
    id: id.toString()
  }).toString()

  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/follow?${params}`
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useFollowUserProps = {
  config?: any
}

export const useFollowUser = ({config}: useFollowUserProps) =>{
  return useMutation(followUser, config)
}

export type UnfollowUserProps = {
  axiosInstance: AxiosInstance,
  id: number;
}

const unfollowUser = async ({axiosInstance, id}: UnfollowUserProps) => {
  const params = new URLSearchParams({
    id: id.toString()
  }).toString()

  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/unfollow?${params}`
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useUnfollowUserProps = {
  config?: any
}

export const useUnfollowUser = ({config}: useUnfollowUserProps) =>{
  return useMutation(unfollowUser, config)
}


export type GetUserFollowersProps = {
  axiosInstance: AxiosInstance,
  id: number,
}

const getUserFollowers = async ({axiosInstance, id}: GetUserFollowersProps) => {
  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/${id}/followers`
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useGetUserFollowersProps = {
  config?: any
}

export const useGetFollowers = ({config}: useGetUserFollowersProps) =>{
  return useMutation(getUserFollowers, config)
}

export type GetUserFollowingsProps = {
  axiosInstance: AxiosInstance,
  id: number,
}

const getUserFollowings = async ({axiosInstance, id}: GetUserFollowingsProps) => {
  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/${id}/followings`
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useGetUserFollowingsProps = {
  config?: any
}

export const useGetFollowings = ({config}: useGetUserFollowingsProps) =>{
  return useMutation(getUserFollowings, config)
}

//WA 57 Upload profile picture

export type UploadProfilePictureProps = {
  axiosInstance: AxiosInstance,
  data: any;
}

const uploadProfilePicture = async ({axiosInstance, data}: UploadProfilePictureProps) => {
  const response = await axiosInstance.post(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/upload-picture`,
      data,
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useUploadProfilePictureProps = {
  config?: any
}

export const useUploadProfilePicture = ({config}: useUploadProfilePictureProps) => {
  return useMutation(uploadProfilePicture, config);
}


export type DeleteProfilePicture = {
  axiosInstance: AxiosInstance
}

const deleteProfilePicture = async ({axiosInstance}: DeleteProfilePicture) => {
  const response = await axiosInstance.delete(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/user/delete-picture`
  )

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useDeleteProfilePicture = {
  config?: any
}

export const useDeleteProfilePicture = ({config}: useDeleteProfilePicture) => {
  return useMutation(deleteProfilePicture, config)
}
