//
// CONFIRM TOKEN
//

import { AxiosInstance } from "axios";
import { useQuery } from "react-query";

export type ConfirmSignupTokenProps = {
  axiosInstance: AxiosInstance;
};

const confirmSignupToken = async (props: ConfirmSignupTokenProps) => {
  const { axiosInstance } = props;
  const searchParams = new URLSearchParams(location.search);
  const token = searchParams.get("token");

  const response = await axiosInstance.get(
    `${process.env.REACT_APP_BACKEND_API_URL}/auth/verify?token=${token}`
  );
  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

type UseConfirmSignupTokenProps = ConfirmSignupTokenProps & {
  config?: any;
};

const useConfirmSignupToken = (props: UseConfirmSignupTokenProps) => {
  const { axiosInstance, config } = props;
  return useQuery(
    ["confirmSignupToken"],
    () => confirmSignupToken({ axiosInstance }),
    config
  );
};

export default useConfirmSignupToken;
