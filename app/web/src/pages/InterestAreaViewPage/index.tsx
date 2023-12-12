import React, { useState, useEffect } from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import { Link, useParams } from "react-router-dom";
import { useAuth } from "../../contexts/AuthContext";
import {
  useGetInterestArea,
  useGetPostsOfInterestArea,
  useGetSubInterestAreasOfInterestArea,
} from "../../hooks/useInterestArea";
import { AccessLevel, accessLevelMapping } from "../InterestAreaUpdatePage";

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
}

const ViewInterestArea = () => {
  const { axiosInstance } = useAuth();
  const { iaId } = useParams();
  const [interestAreaData, setInterestAreaData] = useState<any>(null);
  const [subInterestAreasData, setSubInterestAreasData] = useState<any>(null);
  const [postsData, setPostsData] = useState<Post[] | null>(null);

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

  const { isSuccess: isNestedInterestAreasSuccess } =
    useGetSubInterestAreasOfInterestArea({
      axiosInstance,
      interestAreaId: parseInt(iaId as string),
      config: {
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
        }));
        setPostsData(newDetails);
      },
    },
  });

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
                  <span className="mx-2">Join</span>
                </div>
                <div className="mx-2 my-3 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                  <img
                    className="mx-2"
                    src="/assets/theme/icons/NoNotificationNotSelected.png"
                    style={{ width: "20px" }}
                  />
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
          <div
            style={{
              padding: "10px",
              border: "1px solid #ccc",
              borderRadius: "5px",
              textAlign: "center",
              fontFamily: "Arial, sans-serif",
              color: "#333",
            }}
          >
            <h2>Private Bunch</h2>
            <p>
              This section contains private and confidential information. Access
              is restricted to authorized individuals only.
            </p>
            <p>
              If you have the necessary permissions, please proceed responsibly.
            </p>
          </div>
        )
      )}
    </>
  );
};

export default ViewInterestArea;
