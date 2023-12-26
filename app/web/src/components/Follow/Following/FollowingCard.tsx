import React from 'react';
import {Col, Row, Button} from 'react-bootstrap';
import {EnigmaUser} from "../../../pages/InterestAreaViewPage";
import {Link, useParams} from "react-router-dom";
import {UseMutateFunction} from "react-query";
import {UnfollowUserProps} from "../../../hooks/useUser";
import {useAuth} from "../../../contexts/AuthContext";


type FollowingCardProps = {
    user: EnigmaUser;
    unfollow: (targetId: number) => void;
    follow: (targetId: number) => void;
    style?: object;
    className?: string;
};

const FollowingCard: React.FC<FollowingCardProps> = ({
                                                         user,
                                                         unfollow,
                                                         follow,
                                                         style,
                                                         className,
                                                     }) => {

    const {userData} = useAuth()
    const {userId} = useParams();
    return (
        <div className={`card mt-3 mb-3 border-0 ${className}`} style={style}>
            <Row className="g-0 align-items-center">
                <Col xs={2} className="text-center">
                    {user.pictureUrl && user.pictureUrl.length > 0
                        ? <img
                            src={user.pictureUrl}
                            className="rounded-circle img-fluid object-fit-cover"
                            alt={`${user.name} PP`}
                            style={{width: 50, height: 50}}
                        />
                        : <img
                            src="/assets/PlaceholderProfile.png"
                            className="rounded-circle img-fluid object-fit-cover"
                            alt={`${user.name} PP`}
                            style={{width: 50, height: 50}}
                        />
                    }
                </Col>
                <Col xs={7} className="d-flex flex-column justify-content-center pl-2">
                    <h5 className="card-title mb-0">{user.name}</h5>
                    <Link to={`/profile/${user.id}`}
                          style={{textDecoration: 'none'}}>
                        <p className="card-text text-body-secondary mt-0">@{user.username}</p>
                    </Link>
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
                        {userData.id == parseInt(userId || "-1")
                            ? <span onClick={() => unfollow(user.id)} className="font-weight-bold text-danger p-2"
                                    style={{fontSize: '14px'}}>
                            Unfollow
                            </span>
                            : <span onClick={() => follow(user.id)} className="font-weight-bold text-danger p-2"
                                    style={{fontSize: '14px'}}>
                            Follow
                            </span>
                        }
                    </Button>
                </Col>

            </Row>
        </div>
    );
};

export default FollowingCard;
