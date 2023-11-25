//
// CREATE INTEREST AREA
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import { CreateInterestAreaRequestData } from "../components/InterestArea/InterestAreaCreateCard";

export type CreateInterestAreaProps = CreateInterestAreaRequestData & {
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
  return useMutation(createInterestArea, props);
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
