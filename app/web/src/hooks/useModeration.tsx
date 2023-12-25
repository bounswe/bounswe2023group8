//
//  REPORT AN ISSUE
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";

type Issue = {
  entityId: number;
  entityType: string;
  reason: string;
};

export type ReportAnIssueProps = {
  axiosInstance: AxiosInstance;
  issue: Issue;
};

const reportAnIssue = async ({ axiosInstance, issue }: ReportAnIssueProps) => {
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/report`,
    issue
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useReportAnIssue = (props: {}) => {
  return useMutation(reportAnIssue, props);
};


export type GetModerationsProps = {
  axiosInstance: AxiosInstance,
  type: string,
  interestAreaId?: number,
  postId?: number,
  toUserId?: number,
  fromUserId?: number,
}

const getModerations = async ({axiosInstance, fromUserId, interestAreaId, postId, toUserId, type}: GetModerationsProps) => {
  const params = new URLSearchParams({
    type: type
  })
  if(interestAreaId){
    params.append('interestAreaId', interestAreaId.toString())
  }
  if(postId){
    params.append('postId', postId.toString())
  }
  if(toUserId){
    params.append('toUserId', toUserId.toString())
  }
  if(fromUserId){
    params.append('fromUserId', fromUserId.toString())
  }

  const response = await axiosInstance.get(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation?${params.toString()}`,
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useGetModerationsProps = {
  config?: any;
}

export const useGetModerations = ({config}: useGetModerationsProps) => {
  return useMutation(getModerations, config);
};

export type RemoveSpotProps= {
  axiosInstance: AxiosInstance,
  postId: number,
}

const removePost = async ({axiosInstance, postId}: RemoveSpotProps) => {
  const params = new URLSearchParams({
    postId: postId.toString(),
  }).toString()

  const response = await axiosInstance.delete(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/post?${params}`,
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }

}

type useRemoveSpotProps = {
  config?: any;
}

export const useRemoveSpot = ({config}: useRemoveSpotProps) => {
  return useMutation(removePost, config);
}

export type RemoveInterestAreaProps = {
  axiosInstance: AxiosInstance,
  interestAreaId: number,
}

const removeInterestArea = async ({axiosInstance, interestAreaId}: RemoveInterestAreaProps) => {
  const params = new URLSearchParams({
    interestAreaId: interestAreaId.toString(),
  }).toString()

  const response = await axiosInstance.delete(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/interest-area?${params}`,
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useRemoveInterestAreaProps = {
  config?: any
}

export const useRemoveInterestArea = ({config}: useRemoveInterestAreaProps) => {
  return useMutation(removeInterestArea, config);
}

export type WarnUserProps = {
  axiosInstance: AxiosInstance,
  data: {
    userId: number,
    postId: number,
    reason: string,
  }
}

const warnUser = async ({axiosInstance, data}: WarnUserProps) => {
  const response = await axiosInstance.post(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/warn`,
      data
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useWarnUserProps = {
  config?: any
}

export const useWarnUser = ({config}: useWarnUserProps) => {
  return useMutation(warnUser, config);
}

export type BanUserProps = {
  axiosInstance: AxiosInstance
  data: {
    userId: number,
    postId: number,
    reason: string,
  }
}

const banUser = async ({axiosInstance, data}: BanUserProps) => {
  const response = await axiosInstance.post(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/ban`,
      data
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
}

type useBanUserProps = {
  config?: any,
}

export const useBanUser = ({config}: useBanUserProps) => {
  return useMutation(banUser, config)
}

export type UnbanUserProps = {
  axiosInstance: AxiosInstance,
  userId: number,
  interestAreaId: number,
}

const unbanUser = async ({axiosInstance, interestAreaId, userId}: UnbanUserProps) => {
  const params = new URLSearchParams({
    userId: userId.toString(),
    interestAreaId: interestAreaId.toString(),
  }).toString()

  const response = await axiosInstance.delete(
      `${process.env.REACT_APP_BACKEND_API_URL}/v1/moderation/unban?${params}`,
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }

}

type useUnbanUserProps = {
  config?: any
}

export const useUnbanUser = ({config}: useUnbanUserProps) => {
  return useMutation(unbanUser, config)
}
