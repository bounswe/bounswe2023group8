//
// CREATE INTEREST AREA
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";
import { CreateInterestAreaFormData } from "../components/InterestArea/InterestAreaCreateCard";

export type CreateInterestAreaProps = CreateInterestAreaFormData & {
  axiosInstance: AxiosInstance;
};

const createInterestArea = async (props: CreateInterestAreaProps) => {
  const { axiosInstance, ...data } = props;
  const response = await axiosInstance.post(
    `${process.env.REACT_APP_BACKEND_API_URL}/create_interest_area`,
    data
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useCreateInterestArea = (props: {}) => {
  return useMutation(createInterestArea, props);
};
