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
