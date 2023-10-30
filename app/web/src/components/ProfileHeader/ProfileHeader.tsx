import React from 'react';
import {Col, Row} from "react-bootstrap";

type ProfileHeaderProps = {
    user: {
        id: number,
        name: string,
        nickname: string,
        ia_ids: number[],
        follower_count: number,
        following_count: number,
        all_time_likes: number,
        all_time_dislikes: number,
        user_profile_image: string
    },
    style: object,
    className: string
};
const ProfileHeader = ({
                           user: {
                               all_time_dislikes,
                               all_time_likes,
                               follower_count,
                               following_count,
                               name,
                               nickname,
                               user_profile_image
                           },
                           style,
                           className
                       }: ProfileHeaderProps) => {


    return <div className={`card mt-3 mb-1 ${className}`} style={style}>
        <Row className="g-0">
            <Col className="col-4 justify-content-center my-4" style={{maxHeight: '80px', maxWidth: '80px'}}>
                <img src={user_profile_image} className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                     style={{borderRadius: '50%'}} alt="Furkan PP"/>
            </Col>
            <Col className="col-8">
                <Row className="card-body">
                    <Col className="col-10 m-auto">
                        <h5 className="card-title">{name}</h5>
                        <p className="card-text text-body-secondary">@{nickname}</p>
                        <Row className="justify-content-between">
                            <Col className="card-text">{follower_count} followers</Col>
                            <Col className="card-text">{following_count} following</Col>
                        </Row>
                    </Col>
                    <Col className="col-2 m-auto">
                        <p className="fs-5 bi-hand-thumbs-up-fill text-danger">{all_time_likes}</p>
                        <p className="fs-5 bi-hand-thumbs-down-fill " style={{color: 'green'}}>{all_time_dislikes}</p>
                    </Col>
                </Row>
            </Col>
        </Row>
    </div>
}

export default ProfileHeader;
