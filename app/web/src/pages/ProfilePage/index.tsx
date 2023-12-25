import React, { useEffect } from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import InterestAreaCard from "../../components/InterestArea/InterestAreaCard";
import { Col, Row } from "react-bootstrap";
import ProfileHeader from "../../components/ProfileHeader/ProfileHeader";
import { useAuth } from "../../contexts/AuthContext";
import {
  useGetUserFollowingInterestAreas,
  useGetUserPosts,
  useGetUserProfile,
  useGetUserReputation,
} from "../../hooks/useProfile";
import { useParams } from "react-router-dom";
import { Post } from "../InterestAreaViewPage";

const ProfilePage = () => {
  const { userId } = useParams();

  const { axiosInstance } = useAuth();
  const {
    mutate: getUserProfile,
    data: profileData,
    isSuccess: isSuccessProfile,
  } = useGetUserProfile({});
  const {
    mutate: getUserFollowingInterestAreas,
    data: interestAreas,
    isSuccess: isSuccessInterestAreas,
  } = useGetUserFollowingInterestAreas({});
  const {
    mutate: getUserPosts,
    data: posts,
    isSuccess: isSuccessPosts,
  } = useGetUserPosts({});

  // Use the new hook to get user reputation
  const { data: reputationData, isSuccess: isSuccessReputation } =
    useGetUserReputation({
      axiosInstance: axiosInstance,
      userId: userId || "-1",
    });

  useEffect(() => {
    getUserProfile({
      axiosInstance: axiosInstance,
      userId: userId || "-1",
    });
    getUserFollowingInterestAreas({
      axiosInstance: axiosInstance,
      userId: userId || "-1",
    });
    getUserPosts({
      axiosInstance: axiosInstance,
      userId: userId || "-1",
    });
  }, []);

  return (
    <>
      {isSuccessProfile && (
        <ProfileHeader
          reputation={reputationData?.reputation}
          style={{ background: "#EEF0EB", marginLeft: "60px" }}
          user={profileData}
          className="col-5 border-0"
        />
      )}
      <hr className="mx-3" />
      <Row>
        <Col className="col-4">
          <h5 className="mt-2 mx-3">Bunches</h5>
          <div className="card border-0" style={{ maxHeight: "70vh" }}>
            <hr className="m-0 mx-2" />
            {isSuccessInterestAreas && (
              <div className="card-body overflow-y-auto">
                {interestAreas.map((interestArea: any) => (
                  <InterestAreaCard
                    key={interestArea.id}
                    interestArea={interestArea}
                  />
                ))}
              </div>
            )}
          </div>
        </Col>

        <Col className="col-8">
          <h5 className="mt-2 mx-3">Spots</h5>
          <div className="card border-0" style={{ maxHeight: "70vh" }}>
            <hr className="m-0 mx-2" />
            {isSuccessPosts && (
              <div className="card-body overflow-y-auto">
                {posts.map((post: Post) => {
                  return (
                    <PostPreviewCard
                      key={post.id}
                      content={post.content}
                      createTime={post.createTime}
                      enigmaUser={post.enigmaUser}
                      geolocation={post.geolocation}
                      id={post.id}
                      interestArea={post.interestArea}
                      wikiTags={post.wikiTags}
                      label={post.label}
                      title={post.title}
                      sourceLink={post.sourceLink}
                      upvoteCount={post.upvoteCount}
                      downvoteCount={post.downvoteCount}
                    />
                  );
                })}
              </div>
            )}
          </div>
        </Col>
      </Row>
    </>
  );
};

export default ProfilePage;
