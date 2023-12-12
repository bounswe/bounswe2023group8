import React from 'react';
import { Col, Row, Button } from 'react-bootstrap';

type FollowingCardProps = {
    user: {
        id: number;
        name: string;
        nickname: string;
        ia_ids: number[];
        follower_count: number;
        following_count: number;
        all_time_likes: number;
        all_time_dislikes: number;
        user_profile_image: string;
    };
    style?: object;
    className?: string;
};

const FollowingCard: React.FC<FollowingCardProps> = ({
                                                       user: { name, nickname, user_profile_image },
                                                       style,
                                                       className,
                                                   }) => {
    return (
        <div className={`card mt-3 mb-3 border-0 ${className}`} style={style}>
            <Row className="g-0 align-items-center">
                <Col xs={2} className="text-center">
                    <img
                        src={user_profile_image}
                        className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                        alt={`${name} PP`}
                        style={{ maxWidth: '50px' }}
                    />
                </Col>
                <Col xs={7} className="d-flex flex-column justify-content-center pl-2">
                    <h5 className="card-title mb-0">{name}</h5>
                    <p className="card-text text-body-secondary mt-0">@{nickname}</p>
                </Col>
                <Col xs={3} className="text-center">
                    <Button
                        className="remove-button p-0"
                        style={{
                            width: '90px',
                            height: '32px',
                            borderRadius: '20px',
                            backgroundColor: '#F1F1F1',
                            border: 'none',
                        }}
                    >
                        <span className="font-weight-bold text-danger p-2" style={{ fontSize: '14px' }}>
                            Unfollow
                        </span>
                    </Button>
                </Col>
            </Row>
        </div>
    );
};

export default FollowingCard;
