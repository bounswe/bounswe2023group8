import React, {useEffect} from 'react';
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import InterestAreaCard from '../../components/InterestArea/InterestAreaCard';
import {Col, Row} from "react-bootstrap";
import ProfileHeader from "../../components/ProfileHeader/ProfileHeader";
import {useAuth} from "../../contexts/AuthContext";
import {useGetUserFollowingInterestAreas, useGetUserPosts, useGetUserProfile} from "../../hooks/useProfile";
import {useParams} from "react-router-dom";

const ProfilePage = () => {
  const createInterestAreaListFromMockData = (postIAs: number[]) => {
    return mockInterestAreas.filter((interestArea) => {
      return postIAs.find((postIA) => postIA === interestArea.id);
    });
  };
    const { userId } = useParams();

    const {axiosInstance} = useAuth();
    const {mutate: getUserProfile, data: profileData, isSuccess: isSuccessProfile} = useGetUserProfile({});
    const {mutate: getUserFollowingInterestAreas, data: interestAreas, isSuccess: isSuccessInterestAreas} = useGetUserFollowingInterestAreas({});
    const {mutate: getUserPosts, data: posts, isSuccess: isSuccessPosts} = useGetUserPosts({});

    useEffect(() => {
        getUserProfile({
            axiosInstance: axiosInstance,
            userId: userId || "-1",
        })
        console.log(profileData);
        getUserFollowingInterestAreas({
            axiosInstance: axiosInstance,
            userId: userId || "-1",
        })
        getUserPosts({
            axiosInstance: axiosInstance,
            userId: userId || "-1",
        })
    }, [])


    return <>
        <Row>
            {isSuccessProfile && <ProfileHeader user={profileData} style={{}} className="col-5 border-0"/>}
        </Row>
        <hr className="mx-3"/>
        <Row>
            <Col className="col-4">
                <h5 className="mt-2 mx-3">Interest Areas</h5>
                <div className="card border-0" style={{maxHeight: '70vh'}}>
                    <hr className="m-0 mx-2"/>
                    {isSuccessInterestAreas && <div className="card-body overflow-y-auto">
                        {interestAreas.map((interestArea: any) => (
                            <InterestAreaCard key={interestArea.id} interestArea={interestArea}/>
                        ))}
                    </div>}
                </div>
            </Col>

            <Col className="col-8">
                <h5 className="mt-2 mx-3">Posts</h5>
                <div className="card border-0" style={{maxHeight: '70vh'}}>
                    <hr className="m-0 mx-2"/>
                    {isSuccessPosts && <div className="card-body overflow-y-auto">
                        {posts.map((post: any) => {
                            return <PostPreviewCard
                                key={post.id}
                                post={post}
                                userName={post.enigmaUser.name}
                                tags={post.wikiTags}/>
                        })
                        }
                    </div>}
                </div>
            </Col>
        </Row>
    </>
  );
};

export default ProfilePage;
