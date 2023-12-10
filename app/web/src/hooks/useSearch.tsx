//
// SEARCH GLOBALLY
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";

export type SearchGloballyProps = {
  searchKey: string;
  axiosInstance: AxiosInstance;
};

const searchGlobally = async ({
  axiosInstance,
  searchKey,
}: SearchGloballyProps) => {
  const response = await axiosInstance.get(
    `${
      process.env.REACT_APP_BACKEND_API_URL
    }/v1/search?searchKey=${encodeURIComponent(searchKey)}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useSearchGlobally = (props: {}) => {
  return useMutation(searchGlobally, props);
};
