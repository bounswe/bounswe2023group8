//
// SEARCH WIKI TAGS
//

import { AxiosInstance } from "axios";
import { useMutation } from "react-query";

export type searchWikitagsProps = {
  searchKey: string;
  axiosInstance: AxiosInstance;
};

const searchWikitags = async ({
  axiosInstance,
  searchKey,
}: searchWikitagsProps) => {
  const response = await axiosInstance.get(
    `${
      process.env.REACT_APP_BACKEND_API_URL
    }/v1/wiki/search?searchKey=${encodeURIComponent(searchKey)}`
  );

  if (response.status >= 200 && response.status < 300) {
    return response.data;
  }
};

export const useSearchWikitags = (props: {}) => {
  return useMutation(searchWikitags, props);
};
