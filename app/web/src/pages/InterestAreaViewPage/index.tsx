import React, { useState, useEffect } from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import { Link, useParams } from "react-router-dom";
import { useAuth } from "../../contexts/AuthContext";
import {
  useFollowInterestArea,
  useGetInterestArea,
  useGetPostsOfInterestArea,
  useGetSubInterestAreasOfInterestArea,
} from "../../hooks/useInterestArea";
import { AccessLevel, accessLevelMapping } from "../InterestAreaUpdatePage";
import { useReportAnIssue } from "../../hooks/useModeration";
import { useGetWaitingBunchFollowRequests } from "../../hooks/useUser";

export interface EnigmaUser {
  id: number;
  username: string;
  name: string;
  email: string;
  birthday: string;
  createTime: string;
}

export interface InterestArea {
  id: number;
  accessLevel: string;
  title: string;
  description: string;
  createTime: string;
}

export interface WikiTag {
  id: string;
  label: string;
  description: string;
  isValidTag: boolean;
}

export interface Geolocation {
  latitude: number;
  longitude: number;
  address: string;
}

export interface Post {
  id: number;
  enigmaUser: EnigmaUser;
  interestArea: InterestArea;
  sourceLink: string;
  title: string;
  wikiTags: WikiTag[];
  label: string;
  content: string;
  geolocation: Geolocation;
  createTime: string;
  upvoteCount: number;
  downvoteCount: number;
}

const ViewInterestArea = () => {
  const { axiosInstance } = useAuth();
  const { iaId } = useParams();
  const [interestAreaData, setInterestAreaData] = useState<any>(null);
  const [subInterestAreasData, setSubInterestAreasData] = useState<any>(null);
  const [postsData, setPostsData] = useState<Post[] | null>(null);
  const [isFollowingRequestWaiting, setIsFollowingRequestWaiting] =
    useState(false);

  const { mutate: followInterestArea } = useFollowInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
  });

  const followBunch = () => {
    followInterestArea({
      axiosInstance,
      interestAreaId: parseInt(iaId as string),
    });
  };

  const { isSuccess } = useGetInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      onSuccess: (data: any) => {
        const newDetails = {
          title: data.title,
          wikiTags: data.wikiTags.map((tag: any) => ({
            id: tag.id,
            name: tag.label,
          })),
          description: data.description,
          accessLevel: accessLevelMapping[data.accessLevel as AccessLevel],
        };
        setInterestAreaData(newDetails);
      },
    },
  });

  useGetWaitingBunchFollowRequests({
    axiosInstance,
    config: {
      retry: !isFollowingRequestWaiting,
      enabled: !isFollowingRequestWaiting,
      onSuccess: (data: any) => {
        setIsFollowingRequestWaiting(
          data.some((request: any) => request.id === parseInt(iaId as string))
        );
      },
    },
  });

  const { isSuccess: isNestedInterestAreasSuccess } =
    useGetSubInterestAreasOfInterestArea({
      axiosInstance,
      interestAreaId: parseInt(iaId as string),
      config: {
        retry: !isFollowingRequestWaiting,
        enabled: !isFollowingRequestWaiting,
        onSuccess: (data: any) => {
          const newDetails = data.map((result: any) => ({
            title: result.title,
            id: result.id,
            description: result.description,
            createTime: result.createTime,
          }));
          setSubInterestAreasData(newDetails);
        },
      },
    });
  const [showContent, setShowContent] = useState(false);
  const [showPosts, setShowPosts] = useState(true);
  const [reportReason, setReportReason] = useState("");
  const [showReport, setShowReport] = useState(false);

  useEffect(() => {
    // Set a timeout to update the state after 2 seconds
    const timeoutId = setTimeout(() => {
      setShowContent(true);
    }, 700);

    // Clean up the timeout to avoid memory leaks
    return () => clearTimeout(timeoutId);
  }, []); // Empty dependency array ensures the effect runs only once on component mount

  const { isSuccess: isPostsSuccess } = useGetPostsOfInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      retry: isSuccess,
      enabled: isSuccess,
      onSuccess: (data: Post[]) => {
        const newDetails = data.map((result: Post) => ({
          id: result.id,
          enigmaUser: result.enigmaUser,
          interestArea: result.interestArea,
          sourceLink: result.sourceLink,
          title: result.title,
          wikiTags: result.wikiTags,
          label: result.label,
          content: result.content,
          geolocation: result.geolocation,
          createTime: result.createTime,
          upvoteCount: result.upvoteCount,
          downvoteCount: result.downvoteCount,
        }));
        setPostsData(newDetails);
      },
    },
  });

  const { mutate: reportAnIssue } = useReportAnIssue({
    axiosInstance,
    issue: {
      entityId: parseInt(iaId as string),
      entityType: "interest_area",
      reason: reportReason,
    },
  });

  const reportBunch = () => {
    reportAnIssue({
      axiosInstance,
      issue: {
        entityId: parseInt(iaId as string),
        entityType: "interest_area",
        reason: reportReason,
      },
    });
  };

  return (
    <>
      {isSuccess && isPostsSuccess && isNestedInterestAreasSuccess ? (
        <div className="d-flex">
          <div className="container mt-4 p-4">
            <div
              className="WA-theme-bg-dark rounded-4"
              style={{
                position: "relative",
                zIndex: 2,
                boxShadow: "-5px 5px #000000",
              }}
            >
              <div className="d-flex ">
                <div className="m-3 WA-theme-light">
                  <h1>{interestAreaData?.title}</h1>
                </div>
                <div className="mx-2 my-3 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                  <span onClick={() => followBunch()} className="mx-2">
                    Join
                  </span>
                </div>
                <div className="mx-2 my-3 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                  <img
                    className="mx-2"
                    src="/assets/theme/icons/NoNotificationNotSelected.png"
                    style={{ width: "20px" }}
                  />
                </div>
                <div className="mx-2 my-3 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                  {showReport ? (
                    <>
                      <input
                        type="text"
                        className="form-control mx-4"
                        placeholder="Please write a reason"
                        onChange={(e) => setReportReason(e.target.value)}
                      ></input>
                      <div className="d-flex mx-3">
                        <button onClick={() => reportBunch()} className="btn">
                          Submit
                        </button>
                        <button
                          onClick={() => setShowReport(!showReport)}
                          className="btn"
                        >
                          Close
                        </button>
                      </div>
                    </>
                  ) : (
                    <>
                      <button
                        onClick={() => setShowReport(!showReport)}
                        className="btn mx-3 rounded-5"
                      >
                        Report
                      </button>
                    </>
                  )}
                </div>
              </div>
              <button
                style={{
                  borderRadius: "0px !important",
                  borderTopRightRadius: "25px",
                }}
                className="btn WA-theme-bg-regular"
                onClick={() => setShowPosts(true)}
              >
                <span className="m-3 text-dark">Spots</span>
              </button>
              <button
                className="btn mx-3 WA-theme-bg-solid rounded-3"
                onClick={() => setShowPosts(false)}
              >
                <span className="m-3 text-dark">About</span>
              </button>
            </div>
            <div
              className="WA-theme-bg-regular pt-3 position-relative rounded-4 "
              style={{
                marginTop: "-42px",
                marginLeft: "-21px",
                padding: "52px",
                zIndex: 1,
              }}
            >
              <div className="d-flex mt-5">
                <div className="">Sort By:</div>
                <div className="ms-3 WA-theme-bg-soft rounded-4 d-flex">
                  <div>
                    <img
                      src="/assets/theme/icons/NewFilter.png"
                      style={{ width: "40px" }}
                    />
                  </div>
                  <div className="mx-2 d-flex justify-content-center align-items-center">
                    <span>New</span>
                  </div>
                </div>
                <div className="ms-3 WA-theme-bg-soft rounded-4 d-flex">
                  <div>
                    <img
                      src="/assets/theme/icons/TopIcon.png"
                      style={{ width: "40px" }}
                    />
                  </div>
                  <div className="mx-2 d-flex justify-content-center align-items-center">
                    <span>Top</span>
                  </div>
                </div>
              </div>
            </div>
            {!showPosts && (
              <div className="WA-theme-bg-light p-5 rounded-4">
                <p className="d-flex justify-content-between">
                  <span>{interestAreaData?.description}</span>
                </p>
              </div>
            )}
            {showPosts &&
              postsData &&
              postsData.length > 0 &&
              postsData.map((post) => (
                <div key={post.id} className="my-3">
                  <PostPreviewCard {...post} />
                </div>
              ))}
          </div>

          <div style={{ width: "30%", margin: "50px" }}>
            <div className="mb-5 d-flex flex-column">
              <Link
                style={{ textDecoration: "none", color: "black" }}
                to={"/create_post"}
                state={{
                  interestAreaId: iaId,
                  interestAreaTitle: interestAreaData?.title,
                }}
              >
                <div className="m-2 py-3 px-1 WA-theme-bg-soft rounded-4 d-flex w-50">
                  <div className="mx-2 d-flex justify-content-center align-items-center">
                    <span style={{ whiteSpace: "nowrap" }}>Create Spot</span>
                  </div>
                  <img
                    className="ms-2"
                    src="/assets/theme/icons/Type=Add.png"
                    style={{ width: "20px", height: "20px" }}
                  />
                </div>
              </Link>
              <a
                style={{ textDecoration: "none", color: "black" }}
                href={`/update_interest_area/${iaId}`}
              >
                <div className="m-2 py-3 px-1 WA-theme-bg-soft rounded-4 d-flex w-50">
                  <div className="mx-2 d-flex justify-content-center align-items-center">
                    <span style={{ whiteSpace: "nowrap" }} className="me-3">
                      Edit Bunch
                    </span>
                  </div>
                  <img
                    className="ms-2"
                    src="/assets/theme/icons/EditIcon.png"
                    style={{ width: "20px", height: "20px" }}
                  />
                </div>
              </a>
            </div>
            <div className="mb-3">
              <h2 style={{ marginLeft: "20px" }}>Tags</h2>
              <hr
                className="solid"
                style={{ borderTop: "3px solid black" }}
              ></hr>
              <div className="WA-theme-bg-dark p-3 rounded-4">
                {interestAreaData?.wikiTags.map((tag: any) => (
                  <div
                    key={tag.id}
                    className="m-2 h-2 WA-theme-bg-light d-flex align-items-center justify-content-center rounded-5"
                    style={{
                      height: "45px",
                    }}
                  >
                    #{tag.name}
                  </div>
                ))}
                <div
                  className="m-2 h-2 WA-theme-light WA-theme-separator-light WA-theme-bg-solid d-flex align-items-center justify-content-center rounded-5"
                  style={{
                    height: "45px",
                  }}
                >
                  <img
                    className="mx-2"
                    src="/assets/theme/icons/Type=Add.png"
                    style={{ width: "20px" }}
                  />
                  Suggest
                </div>
              </div>
            </div>
            <div>
              <h2>Sub-Bunches</h2>
              <hr
                className="solid"
                style={{ borderTop: "3px solid black" }}
              ></hr>
              <div className="WA-theme-bg-dark p-3 rounded-4">
                {subInterestAreasData?.map((subIA: any, index: number) => (
                  <div
                    key={index}
                    className="m-2 h-2 WA-theme-light WA-theme-separator-light WA-theme-bg-solid d-flex align-items-center justify-content-center rounded-5"
                    style={{
                      height: "45px",
                    }}
                  >
                    {subIA.title} <br></br>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      ) : (
        showContent && (
          <div className="m-3 p-3" style={{ backgroundColor: "#fffaf6" }}>
            <h2>Private Bunch</h2>
            <p>
              This section contains private and confidential information. Access
              is restricted to authorized individuals only. You can send a
              request to join this bunch.
            </p>
            <div className="m-3 d-flex justify-content-center align-items-center rounded-5">
              {isFollowingRequestWaiting ? (
                <button className="btn mx-2 WA-theme-bg-positive WA-theme-light">
                  Waiting for approval
                </button>
              ) : (
                <button
                  onClick={() => followBunch()}
                  className="btn mx-2 WA-theme-bg-dark WA-theme-light"
                >
                  Join
                </button>
              )}
            </div>
          </div>
        )
      )}
    </>
  );
};

export default ViewInterestArea;
