import React from 'react';
import { useParams } from 'react-router-dom';
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import mockPosts from "../../mockData/milestone1/451_posts.json";
import mockUsers from "../../mockData/milestone1/451_users.json";
import mockInterestAreas from "../../mockData/milestone1/451_interest_areas.json";
import mockDetailedPosts from "../../mockData/milestone1/451_detailed_post.json"
import { Col, Row } from "react-bootstrap";
import ProfileHeader from "../../components/ProfileHeader/ProfileHeader";
import DetailedPostCard from '../../components/Post/DetailedPostCard';

const PostViewPage = () => {
  const { postId } = useParams();

  const createInterestAreaListFromMockData = (postIAs: number[]) => {
    return mockInterestAreas.filter((interestArea) => {
      return postIAs.find((postIA) => postIA === interestArea.id);
    })
  };

  type postTypes = {
    id: number,
    user_id: number,
    ia_ids: number[],
    source_link: string,
    content: string,
    date: string,
    spotted_at: string
  };

  const getUserName = (post: postTypes): string | undefined => {
    return mockUsers.find((user) => user.id === post.user_id)?.name;
  };

  const selectedPost = mockDetailedPosts.find((post) => post.id.toString() === postId);

  if (!selectedPost) {
    return <p>Post not found</p>;
  }

  return (
    <>
      <div style={{ display: 'flex' }}>
        <div className="card-body overflow-y-auto">
          <DetailedPostCard
            key={selectedPost.id}
            post={selectedPost}
            userName={getUserName(selectedPost)}
            interestAreas={createInterestAreaListFromMockData(selectedPost.ia_ids)}
          />
        </div>
        <div className="card-body overflow-y-auto" style={{ width: '40%' }}>
        </div>
      </div>
    </>
  );
}

export default PostViewPage;