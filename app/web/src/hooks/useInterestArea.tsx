//
// CREATE INTEREST AREA
//

import { AxiosInstance } from "axios";
import { useMutation, useQuery } from "react-query";
import { InterestAreaRequestData } from "../components/InterestArea/InterestAreaCreateCard";
import { useNavigate } from "react-router-dom";

export type CreateInterestAreaProps = InterestAreaRequestData & {
  axiosInstance: AxiosInstance;
};

const createInterestArea = async (props: CreateInterestAreaProps) => {
  const { axiosInstance, ...data } = props;
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/interest-area`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useCreateInterestArea = (props: {}) => {
  const navigate = useNavigate();
  return useMutation(createInterestArea, {
    ...props,
    onSuccess: (data: any) => navigate(`/interest-area/${data.id}`),
  });
};

//
// SEARCH INTEREST AREA
//

export type SearchInterestAreaProps = {
  searchKey: string;
  axiosInstance: AxiosInstance;
};

const searchInterestArea = async ({
  axiosInstance,
  searchKey,
}: SearchInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${
      process.env.REACT_APP_BACKEND_API_URL
    }/v1/interest-area/search?searchKey=${encodeURIComponent(searchKey)}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useSearchInterestArea = (props: {}) => {
  return useMutation(searchInterestArea, props);
};

//
// UPDATE INTEREST AREA
//

export type UpdateInterestAreaProps = InterestAreaRequestData & {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const updateInterestArea = async ({
  axiosInstance,
  interestAreaId,
  ...data
}: UpdateInterestAreaProps) => {
  const response = await axiosInstance.put(
    `${
      process.env.REACT_APP_BACKEND_API_URL
    }/v1/interest-area?id=${encodeURIComponent(interestAreaId)}`,
    data
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useUpdateInterestArea = (props: {}) => {
  const navigate = useNavigate();
  return useMutation(updateInterestArea, {
    ...props,
    onSuccess: (data: any) => navigate(`/interest-area/${data.id}`),
  });
};

//
// GET INTEREST AREA
//

export type GetInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const getInterestArea = async ({
  axiosInstance,
  interestAreaId,
}: GetInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${
      process.env.REACT_APP_BACKEND_API_URL
    }/v1/interest-area?id=${encodeURIComponent(interestAreaId)}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetInterestAreaProps = GetInterestAreaProps & {
  config?: any;
};

export const useGetInterestArea = (props: useGetInterestAreaProps) => {
  const { interestAreaId, config } = props;
  return useQuery(
    ["getInterestArea", interestAreaId],
    () => getInterestArea(props),
    config
  );
};

//
// GET SUB INTEREST AREAS OF INTEREST AREA
//

export type GetSubInterestAreasOfInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const getSubInterestAreasOfInterestArea = async ({
  axiosInstance,
  interestAreaId,
}: GetSubInterestAreasOfInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/interest-area/${interestAreaId}/nested-interest-areas`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetSubInterestAreasOfInterestAreaProps =
  GetSubInterestAreasOfInterestAreaProps & {
    config?: any;
  };

export const useGetSubInterestAreasOfInterestArea = (
  props: useGetSubInterestAreasOfInterestAreaProps
) => {
  const { interestAreaId, config } = props;
  return useQuery(
    ["getSubInterestAreasOfInterestArea", interestAreaId],
    () => getSubInterestAreasOfInterestArea(props),
    config
  );
};

//
// GET POSTS OF INTEREST AREA
//

export type GetPostsOfInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const getPostsOfInterestArea = async ({
  axiosInstance,
  interestAreaId,
}: GetPostsOfInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/interest-area/${interestAreaId}/posts`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useGetPostsOfInterestAreaProps = GetPostsOfInterestAreaProps & {
  config?: any;
};

export const useGetPostsOfInterestArea = (
  props: useGetPostsOfInterestAreaProps
) => {
  const { interestAreaId, config } = props;
  return useQuery(
    ["getPostsOfInterestArea", interestAreaId],
    () => getPostsOfInterestArea(props),
    config
  );
};

//
//  FOLLOW INTEREST AREA
//

export type FollowInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const followInterestArea = async ({
  axiosInstance,
  interestAreaId,
}: FollowInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/interest-area/follow?id=${interestAreaId}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useFollowInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
  config?: any;
};

export const useFollowInterestArea = (props: useFollowInterestAreaProps) => {
  const { config } = props;
  return useMutation(followInterestArea, config);
};

//
//  UNFOLLOW INTEREST AREA
//

export type UnfollowInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
};

const unfollowInterestArea = async ({
  axiosInstance,
  interestAreaId,
}: UnfollowInterestAreaProps) => {
  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/interest-area/unfollow?id=${interestAreaId}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type useUnfollowInterestAreaProps = {
  axiosInstance: AxiosInstance;
  interestAreaId: number;
  config?: any;
};

export const useUnfollowInterestArea = (
  props: useUnfollowInterestAreaProps
) => {
  const { config } = props;
  return useMutation(unfollowInterestArea, config);
};
