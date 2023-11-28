import React, { useState } from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import {Link, useParams} from "react-router-dom";
import Tag from "../../components/Tag/Tag";
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
        <div style={{ display: "flex" }}>
          <div
            className="container mt-4"
            style={{
              width: "75%",
              height: "100%",
              borderRight: "solid #C2C2C2",
              padding: "50px",
            }}
          >
            <h1
              className="fw-bold"
              style={{
                marginBottom: "50px",
                display: "inline-block",
                padding: "10px 20px 10px 20px",
                textTransform: "uppercase",
                background: "#E0E0E0",
                borderRadius: "20px",
              }}
            >
              {interestAreaData?.title}
            </h1>
            <p className="d-flex  justify-content-between">
              <span>{interestAreaData?.description}</span>
              <span className="">
                <Link className="btn btn-primary"
                      to={"/create_post"}
                      state={{ interestAreaId: iaId, interestAreaTitle: interestAreaData?.title}}
                >
                  Create New Spot
                </Link>
              </span></p>
            <hr></hr>
            {postsData &&
              postsData.length > 0 &&
              postsData.map((post) => (
                <div key={post.id} style={{ marginBottom: "35px" }}>
                  <PostPreviewCard {...post} />
                </div>
              ))}
          </div>

          <div style={{ width: "25%", margin: "50px" }}>
            <div style={{ marginBottom: "70px" }}>
              <h2 style={{ marginLeft: "20px" }}>IA Tags</h2>
              <hr
                className="solid"
                style={{ borderTop: "3px solid black" }}
              ></hr>
              {interestAreaData?.wikiTags.map((tag: any) => (
                <div
                  key={tag.id}
                  style={{
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    background: "#C2C2C2",
                    borderRadius: "10px",
                    width: "224px",
                    fontSize: "20px",
                    height: "45px",
                    margin: "15px",
                  }}
                >
                  #{tag.name}
                </div>
              ))}
            </div>
            <div>
              <h2>Related IA&apos;s</h2>
              <hr
                className="solid"
                style={{ borderTop: "3px solid black" }}
              ></hr>
              {subInterestAreasData?.map((subIA: any, index: number) => (
                <div
                  key={index}
                  style={{
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    background: "#C2C2C2",
                    borderRadius: "10px",
                    width: "224px",
                    fontSize: "20px",
                    height: "45px",
                    margin: "15px",
                  }}
                >
                  {subIA.title} <br></br>
                </div>
              ))}
            </div>
          </div>
        </div>
      ) : (
        <div>Waiting for data...</div>
      )}
    </>
  );
};

export default ViewInterestArea;
