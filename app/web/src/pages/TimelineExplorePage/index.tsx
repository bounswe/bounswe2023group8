import React from 'react';
import { Row, Col } from 'react-bootstrap';
import Tag from '../../components/Tag/Tag';
import mockTags from '../../mockData/milestone1/451_tags.json';
import mockPosts from '../../mockData/milestone1/451_posts.json';
import mockUsers from '../../mockData/milestone1/451_users.json';
import ProfileDisplay from '../../components/ProfileDisplay/ProfileDisplay';

// Utility function to calculate tag width
const calculateTagWidth = (text: string): string => {
    const averageCharacterWidth = 10; // Adjust this value based on your styling
    const minWidth = 50; // Minimum width to ensure visibility
    const width = Math.max(text.length * averageCharacterWidth, minWidth);
    return `${width}px`;
};

const TimelineExplorePage: React.FC = () => {
    // Get random tags
    const getRandomTags = (count: number) => {
        const shuffledTags = mockTags.sort(() => 0.5 - Math.random());
        return shuffledTags.slice(0, count);
    };

    // Get 3 random posts
    const getRandomPosts = (count: number) => {
        const shuffledPosts = mockPosts.sort(() => 0.5 - Math.random());
        return shuffledPosts.slice(0, count);
    };

    // Get 4 random users
    const getRandomUsers = (count: number) => {
        const shuffledUsers = mockUsers.sort(() => 0.5 - Math.random());
        return shuffledUsers.slice(0, count);
    };

    const randomTags = getRandomTags(6);
    const randomPosts = getRandomPosts(3);
    const randomUsers = getRandomUsers(4);

    return (
        <div className="container mt-3">
            {/* Find your interests */}
            <Row className="gx-3">
                <h2>Find your interests </h2>
                {randomTags.map((tag, index) => (
                    <Col key={tag.id} xs={6} md={2}>
                        <Tag
                            className={`mb-2 ${index === randomTags.length - 1 ? 'me-auto' : ''}`}
                            name={tag.area_name}
                        />
                    </Col>
                ))}
                <Col xs={6} md={6} className="d-flex align-items-center">
                    <p className="mb-2 ms-2">...and many more!</p>
                </Col>
            </Row>

            {/* Trending */}
            <div className="mb-4">
                <h2>Trending</h2>
                <Row className="gx-3">
                    {randomPosts.map((post) => (
                        <Col key={post.id} xs={12} md={4} className="mb-3">
                            <div className="card mb-3 bg-primary-subtle">
                                <div className="card-body">
                                    <h6 className="card-title truncate-text-4">{post.content}</h6>
                                    <p className="card-text justify-content-between d-flex">
                                        <small className="text-body-secondary">
                                            Shared by {randomUsers[Math.floor(Math.random() * 4)].name}
                                        </small>
                                    </p>
                                </div>
                            </div>
                        </Col>
                    ))}
                </Row>
            </div>

            {/* Discover popular users */}
            <div>
                <h2>Discover popular users</h2>
                <Row className="gx-3">
                    {randomUsers.map((user) => (
                        <Col key={user.id} xs={12} md={3} className="mb-3">
                            <ProfileDisplay user={user} style={{ maxHeight: '300px' }} className="border-0" />
                        </Col>
                    ))}
                </Row>
            </div>
        </div>
    );
};

export default TimelineExplorePage;
