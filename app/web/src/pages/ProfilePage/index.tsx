import React from 'react';
import PostPreviewCard from "../../components/Post/PostPreviewCard";
import mockPosts from "../../mockData/milestone1/451_posts.json";
import mockUsers from "../../mockData/milestone1/451_users.json";
import mockInterestAreas from "../../mockData/milestone1/451_interest_areas.json";
import {Col, Row} from "react-bootstrap";
import ProfileHeader from "../../components/ProfileHeader/ProfileHeader";

const ProfilePage = () => {

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
        created_at: string
    };
    const getUserName = (post: postTypes): string | undefined => {
        return mockUsers.find(
            (user) => user.id === post.user_id)?.name;
    }

    return <>
        <Row>
            <ProfileHeader user={mockUsers[0]} style={{}} className="col-5 border-0"/>
        </Row>
        <hr className="mx-3"/>
        <Row>
            <Col className="col-4">
            {/*Interest Area List here*/}
            </Col>
            <Col className="col-8">
                <h5 className="mt-2 mx-3">Posts</h5>
                <div className="card border-0" style={{maxHeight: '70vh'}}>
                    <hr className="m-0 mx-2"/>
                    <div className="card-body overflow-y-auto">
                        {mockPosts.map((mockPost) => {
                            return <PostPreviewCard
                                key={mockPost.id}
                                post={mockPost}
                                userName={getUserName(mockPost)}
                                interestAreas={createInterestAreaListFromMockData(mockPost.ia_ids)}/>
                        })
                        }
                    </div>
                </div>
            </Col>
        </Row>
    </>
}

export default ProfilePage
;
