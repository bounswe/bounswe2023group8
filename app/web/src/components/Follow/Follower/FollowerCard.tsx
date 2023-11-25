import React from 'react';
import { Col, Row, Button } from 'react-bootstrap';

type FollowerCardProps = {
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

const FollowerCard: React.FC<FollowerCardProps> = ({
                                                       user: { name, nickname, user_profile_image },
                                                       style,
                                                       className,
                                                   }) => {
    return (
        <div className={`card mt-3 mb-1 ${className}`} style={style}>
            <Row className="g-0">
                <Col className="col-4 justify-content-center my-4" style={{ maxHeight: '80px', maxWidth: '80px' }}>
                    <img
                        src={user_profile_image}
                        className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                        style={{ borderRadius: '50%' }}
                        alt={`${name} PP`}
                    />
                </Col>
                <Col className="col-8">
                    <Row className="card-body">
                        <Col className="col-10 m-auto">
                            <h5 className="card-title">{name}</h5>
                            <p className="card-text text-body-secondary">@{nickname}</p>
                        </Col>
                        <Col className="col-2 m-auto">
                            <Button
                                className="remove-button"
                                style={{
                                    border: 'none',
                                    width: '90px',
                                    height: '32px',
                                    borderRadius: '20px',
                                    background: '#F1F1F1',
                                    marginLeft: 'auto',
                                    // marginRight: '12px',
                                }}
                            >
                                <span
                                    style={{
                                        fontFamily: 'Inter',
                                        fontSize: '16px',
                                        fontWeight: 400,
                                        lineHeight: '19px',
                                        letterSpacing: '-0.017em',
                                        textAlign: 'center',
                                        color: '#F13030',
                                    }}
                                >
                                    Remove
                                </span>
                            </Button>
                        </Col>
                    </Row>
                </Col>
            </Row>
        </div>
    );
};

export default FollowerCard;
