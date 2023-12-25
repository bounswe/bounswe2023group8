import React, { useState, useEffect } from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import { Link, useParams } from "react-router-dom";
import { useAuth } from "../../contexts/AuthContext";
import {
  useAcceptFollowRequest,
  useFollowInterestArea,
  useGetFollowRequestsOfInterestArea,
  useGetInterestArea,
  useGetPostsOfInterestArea,
  useGetSubInterestAreasOfInterestArea,
  useRejectFollowRequest,
  useUnfollowInterestArea,
} from "../../hooks/useInterestArea";
import { AccessLevel, accessLevelMapping } from "../InterestAreaUpdatePage";
import { useReportAnIssue } from "../../hooks/useModeration";
import {
  useGetUserFollowingInterestAreas,
  useGetWaitingBunchFollowRequests,
} from "../../hooks/useUser";
import SuggestTagModal from "../../components/SuggestTags/SuggestTagModal";
import { useToastContext } from "../../contexts/ToastContext";
import { Modal } from "react-bootstrap";

export interface EnigmaUser {
  id: number;
  username: string;
  name: string;
  email: string;
  birthday: string;
  pictureUrl: string;
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
  const { axiosInstance, userData } = useAuth();
  const { iaId } = useParams();
  const [interestAreaData, setInterestAreaData] = useState<any>(null);
  const [subInterestAreasData, setSubInterestAreasData] = useState<any>(null);
  const [postsData, setPostsData] = useState<Post[] | null>(null);
  const [filteredAndSortedPosts, setFilteredAndSortedPostsData] = useState<
    Post[] | null
  >(null);
  const [isFollowingRequestWaiting, setIsFollowingRequestWaiting] =
    useState(false);
  const [isUserFollowing, setIsUserFollowing] = useState(false);

  const [suggestTagModalShow, setSuggestTagModalShow] = useState(false);
  const handleSuggestTagModalShow = () => {
    setSuggestTagModalShow(!suggestTagModalShow);
  };

  const { mutate: followInterestArea } = useFollowInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      onSuccess: () => {
        refetch();
        refetchInterestArea();
        refetchUserFollowingBunches();
        const tempState = toastState.filter((toast) => {
          return toast.message != "Followed the Bunch successfully!";
        });
        setToastState([
          ...tempState,
          {
            message: "Followed the Bunch successfully!",
            display: true,
            isError: false,
          },
        ]);
        setTimeout(
          () =>
            setToastState(
              toastState.filter((toast) => {
                return toast.message != "Followed the Bunch successfully!";
              })
            ),
          6000
        );
      },
      onError: () => {
        const tempState = toastState.filter((toast) => {
          return toast.message != "You are already following!";
        });
        setToastState([
          ...tempState,
          {
            message: "You are already following!",
            display: true,
            isError: true,
          },
        ]);
        setTimeout(
          () =>
            setToastState(
              toastState.filter((toast) => {
                return toast.message != "You are already following!";
              })
            ),
          6000
        );
      },
    },
  });

  const { refetch: refetchUserFollowingBunches } =
    useGetUserFollowingInterestAreas({
      axiosInstance,
      id: userData.id,
      config: {
        onSuccess: (data: any) => {
          setIsUserFollowing(
            data.some((ia: any) => ia.id === parseInt(iaId as string))
          );
        },
      },
    });

  const { toastState, setToastState } = useToastContext();
  const { mutate: unfollowInterestArea } = useUnfollowInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      onSuccess: () => {
        refetch();
        refetchInterestArea();
        refetchUserFollowingBunches();
        const tempState = toastState.filter((toast) => {
          return toast.message != "Unfollowed the Bunch successfully!";
        });
        setToastState([
          ...tempState,
          {
            message: "Unfollowed the Bunch successfully!",
            display: true,
            isError: false,
          },
        ]);
        setTimeout(
          () =>
            setToastState(
              toastState.filter((toast) => {
                return toast.message != "Unfollowed the Bunch successfully!";
              })
            ),
          6000
        );
      },
      onError: () => {
        const tempState = toastState.filter((toast) => {
          return toast.message != "You are not following already!";
        });
        setToastState([
          ...tempState,
          {
            message: "You are not following already!",
            display: true,
            isError: true,
          },
        ]);
        setTimeout(
          () =>
            setToastState(
              toastState.filter((toast) => {
                return toast.message != "You are not following already!";
              })
            ),
          6000
        );
      },
    },
  });

  const followBunch = () => {
    followInterestArea({
      axiosInstance,
      interestAreaId: parseInt(iaId as string),
    });
  };

  const unFollowBunch = () => {
    unfollowInterestArea({
      axiosInstance,
      interestAreaId: parseInt(iaId as string),
    });
  };

  const { isSuccess, refetch: refetchInterestArea } = useGetInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      onSuccess: (data: any) => {
        const newDetails = {
          creatorId: data.creatorId,
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

  const { refetch } = useGetWaitingBunchFollowRequests({
    axiosInstance,
    config: {
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
        enabled: isSuccess,
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
  const [showFollowRequests, setShowFollowRequests] = useState(false);
  const [reportReason, setReportReason] = useState("");
  const [showReport, setShowReport] = useState(false);
  const [sortType, setSortType] = useState("new");
  const [filterType, setFilterType] = useState("ALL");

  useEffect(() => {
    // Set a timeout to update the state after 2 seconds
    const timeoutId = setTimeout(() => {
      setShowContent(true);
    }, 700);

    // Clean up the timeout to avoid memory leaks
    return () => clearTimeout(timeoutId);
  }, []); // Empty dependency array ensures the effect runs only once on component mount

  const {
    data: followRequestsData,
    refetch: refetchGetFollowRequests,
    isSuccess: isGetFollowRequestSuccess,
  } = useGetFollowRequestsOfInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
      enabled: isSuccess,
    },
  });

  const { mutate: acceptFollowRequest } = useAcceptFollowRequest({
    axiosInstance,
    requestId: -1,
    config: {
      onSuccess: () => {
        refetchGetFollowRequests();
      },
    },
  });

  const acceptRequest = (requestId: number) => {
    acceptFollowRequest({
      axiosInstance,
      requestId: requestId,
    });
  };

  const { mutate: rejectFollowRequest } = useRejectFollowRequest({
    axiosInstance,
    requestId: -1,
    config: {
      onSuccess: () => {
        refetchGetFollowRequests();
      },
    },
  });

  const rejectRequest = (requestId: number) => {
    rejectFollowRequest({
      axiosInstance,
      requestId: requestId,
    });
  };

  const { isSuccess: isPostsSuccess } = useGetPostsOfInterestArea({
    axiosInstance,
    interestAreaId: parseInt(iaId as string),
    config: {
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
        const sortedByCreateTime = newDetails
          ?.slice()
          .sort(
            (a, b) =>
              Number(new Date(b.createTime)) - Number(new Date(a.createTime))
          );
        setPostsData(sortedByCreateTime || null);
        setFilteredAndSortedPostsData(sortedByCreateTime || null);
      },
    },
  });

  useEffect(() => {
    if (sortType === "new") {
      const sortedByCreateTime = filteredAndSortedPosts
        ?.slice()
        .sort(
          (a, b) =>
            Number(new Date(b.createTime)) - Number(new Date(a.createTime))
        );
      setFilteredAndSortedPostsData(sortedByCreateTime || null);
    } else if (sortType === "top") {
      const sortedByUpvoteCount = filteredAndSortedPosts
        ?.slice()
        .sort(
          (a, b) =>
            Number(b.upvoteCount) -
            Number(b.downvoteCount) -
            (Number(a.upvoteCount) - Number(a.downvoteCount))
        );
      setFilteredAndSortedPostsData(sortedByUpvoteCount || null);
    }
  }, [sortType]);

  useEffect(() => {
    let sortedData = postsData?.slice();
    if (sortType === "new") {
      sortedData = postsData
        ?.slice()
        .sort(
          (a, b) =>
            Number(new Date(b.createTime)) - Number(new Date(a.createTime))
        );
    } else if (sortType === "top") {
      sortedData = postsData
        ?.slice()
        .sort(
          (a, b) =>
            Number(b.upvoteCount) -
            Number(b.downvoteCount) -
            (Number(a.upvoteCount) - Number(a.downvoteCount))
        );
    }
    const filteredPosts = sortedData?.filter(
      (post) => post.label === filterType || filterType === "ALL"
    );
    setFilteredAndSortedPostsData(filteredPosts || null);
  }, [filterType]);

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
                {isUserFollowing ? (
                  <>
                    <div
                      onClick={() => unFollowBunch()}
                      style={{ cursor: "pointer" }}
                      className="mx-2 my-3 px-2 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5"
                    >
                      Unfollow
                    </div>
                  </>
                ) : (
                  <>
                    <div
                      onClick={() => followBunch()}
                      style={{ cursor: "pointer" }}
                      className="mx-2 my-3 px-2 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5"
                    >
                      Follow
                    </div>
                  </>
                )}
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
              {isGetFollowRequestSuccess && followRequestsData?.length > 0 && (
                <button
                  className="btn mx-3 WA-theme-bg-solid rounded-3"
                  onClick={() => setShowFollowRequests(true)}
                >
                  <span className="m-3 text-dark">Follow Requests</span>
                </button>
              )}
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
                <div
                  className="ms-3 WA-theme-bg-soft rounded-4 d-flex"
                  onClick={() => setSortType("new")}
                >
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
                <div
                  className="ms-3 WA-theme-bg-soft rounded-4 d-flex"
                  onClick={() => setSortType("top")}
                >
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
              <div className="d-flex mt-5">
                <div className="">Filter By:</div>
                <div
                  className="ms-3 WA-theme-bg-soft rounded-4 d-flex"
                  onClick={() => setSortType("new")}
                >
                  <div className="mx-2 d-flex justify-content-center align-items-center">
                    <div className="mb-3">
                      <label htmlFor="label" className="form-label ">
                        Label:
                      </label>
                      <select
                        id="label"
                        className="form-select"
                        name="label"
                        onChange={(e) => {
                          setFilterType(e.target.value);
                        }}
                      >
                        <option value={"All".toUpperCase()}>All</option>
                        <option value={"Discussion".toUpperCase()}>
                          Discussion
                        </option>
                        <option value={"Documentation".toUpperCase()}>
                          Documentation
                        </option>
                        <option value={"Learning".toUpperCase()}>
                          Learning
                        </option>
                        <option value={"News".toUpperCase()}>News</option>
                        <option value={"Research".toUpperCase()}>
                          Research
                        </option>
                      </select>
                    </div>
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
              filteredAndSortedPosts &&
              filteredAndSortedPosts.length > 0 &&
              filteredAndSortedPosts.map((post) => (
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
              {userData.id == interestAreaData?.creatorId ? (
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
              ) : (
                <div
                  className="w-50 m-2 py-3 px-1 WA-theme-bg-soft rounded-4 d-flex justify-content-center"
                  style={{ cursor: "pointer" }}
                  onClick={handleSuggestTagModalShow}
                >
                  Suggest Tags
                </div>
              )}
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
          <>
            <div className="card WA-theme-bg-dark m-3">
              <h1 className="m-3">{interestAreaData?.title}</h1>
              <h5 className="m-3">{interestAreaData?.description}</h5>
            </div>
            <div>
              <div className="m-3 p-3 WA-theme-bg-regular">
                <h2>You&apos;re not allowed to see this bunch</h2>
                <p>
                  This section contains private and confidential information.
                  Access is restricted to authorized individuals only.
                </p>
                <p>You can send a request to join this bunch.</p>
                <div className="m-3 d-flex justify-content-center align-items-center rounded-5">
                  {isFollowingRequestWaiting ? (
                    <button
                      onClick={() => unFollowBunch()}
                      className="btn mx-2 WA-theme-bg-dark WA-theme-light"
                    >
                      Unfollow
                    </button>
                  ) : (
                    <button
                      onClick={() => followBunch()}
                      className="btn mx-2 WA-theme-bg-dark WA-theme-light"
                    >
                      Follow
                    </button>
                  )}
                </div>
              </div>
            </div>
          </>
        )
      )}
      <SuggestTagModal
        handleSuggestTagModalShow={handleSuggestTagModalShow}
        suggestTagModalShow={suggestTagModalShow}
        entityId={parseInt(iaId || "-1")}
        entityType={1}
      />
      <Modal
        show={showFollowRequests}
        onHide={() => setShowFollowRequests(false)}
      >
        <Modal.Header closeButton>
          <Modal.Title>Follow Requests</Modal.Title>
        </Modal.Header>

        <Modal.Body>
          {followRequestsData &&
            followRequestsData.map((request: any) => (
              <>
                <div
                  key={request.requestId}
                  className="d-flex flex-column justify-content-center align-items-center"
                >
                  <div>
                    @{request.follower.username} - {request.follower.name}
                  </div>
                  <div>
                    <button
                      onClick={() => acceptRequest(request.requestId)}
                      className="btn btn-success m-2"
                    >
                      Accept
                    </button>
                    <button
                      onClick={() => rejectRequest(request.requestId)}
                      className="btn btn-danger m-2"
                    >
                      Reject
                    </button>
                  </div>
                </div>
                <hr></hr>
              </>
            ))}
        </Modal.Body>
      </Modal>
    </>
  );
};

export default ViewInterestArea;
