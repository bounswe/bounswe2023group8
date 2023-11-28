import React, {useEffect} from 'react';
import { useParams } from 'react-router-dom';
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import mockPosts from "../../mockData/milestone1/451_posts.json";
import mockUsers from "../../mockData/milestone1/451_users.json";
import mockInterestAreas from "../../mockData/milestone1/451_interest_areas.json";
import mockDetailedPosts from "../../mockData/milestone1/451_detailed_post.json"
import { Col, Row } from "react-bootstrap";
import ProfileHeader from "../../components/ProfileHeader/ProfileHeader";
import DetailedPostCard from '../../components/Post/DetailedPostCard';
import {useGetPost} from "../../hooks/usePost";
import {useAuth} from "../../contexts/AuthContext";

const PostViewPage = () => {
  const { postId } = useParams();

  const { axiosInstance} = useAuth();
  const {mutate, data, isSuccess} = useGetPost({});

  useEffect(() => {
    mutate({
      axiosInstance: axiosInstance,
      id: postId || "1",
    })

  }, [])

  return (
    <>
      <div style={{ display: 'flex' }}>
        <div className="card-body overflow-y-auto">
          {data && <DetailedPostCard
            post={data}
          />}
        </div>
        <div className="card-body overflow-y-auto" >
        </div>
      </div>
    </>
  );
}

export default PostViewPage;
