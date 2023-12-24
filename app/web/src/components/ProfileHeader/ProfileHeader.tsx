import React, {useState} from 'react';
import {Col, Row} from "react-bootstrap";
import SpanWithOnClick from "../shared/SpanWithOnClick/SpanWithOnClick";
import FollowerModal from "../Follow/Follower/FollowerModal";
import FollowingModal from "../Follow/Following/FollowingModal";

type ProfileHeaderProps = {
    user: {
        id: number,
        name: string,
        username: string,
        followers: number,
        following: number,
        pictureUrl: string
    },
    style: object,
    className: string
};


const ProfileHeader = ({
                           user: {
                               id,
                               name,
                               username,
                               followers,
                               following,
                               pictureUrl,
                           },
                           style,
                           className
                       }: ProfileHeaderProps) => {
    const [showFollowerModal, setShowFollowerModal] = useState(false);
    const [showFollowingModal, setShowFollowingModal] = useState(false);

    const handleFollowerModal = () =>{
        setShowFollowerModal(!showFollowerModal);
    }


    const handleFollowingModal = () =>{
        setShowFollowingModal(!showFollowingModal);
    }

    return <div className={`card mt-3 mb-1 ${className}`} style={style}>
        <Row className="g-0">
            <Col className="col-4 justify-content-center my-4" style={{maxHeight: '80px', maxWidth: '80px'}}>
                {pictureUrl
                    ? <img src={pictureUrl} className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                           style={{borderRadius: '50%'}} alt="PP goes here"/>
                    : <h1 className="bi bi-person-circle display-1 mx-4"></h1>}
            </Col>
            <Col className="col-8">
                <Row className="card-body">
                    <Col className="col-10 m-auto">
                    <h5 className="card-title" style={{ fontSize: '2rem' }}>{name}</h5>
                    <p className="card-text text-body-secondary" style={{ fontSize: '1.5rem' }}>@{username}</p>

                        <Row className="justify-content-between">
                            <Col className="card-text" style={{ fontSize: '1.2rem' }}>
                                <SpanWithOnClick className={""} text={`${followers} followers`}
                                                 onClick={handleFollowerModal}/>
                            </Col>
                            <Col className="card-text" style={{ fontSize: '1.2rem'}}>
                                <SpanWithOnClick className={""} text={`${following} following`}
                                                 onClick={handleFollowingModal}/>
                            </Col>
                        </Row>
                    </Col>
                    {/*<Col className="col-2 m-auto">*/}
                    {/*    <p className="fs-5 bi-hand-thumbs-up-fill " style={{color: 'green'}}>{all_time_likes}</p>*/}
                    {/*    <p className="fs-5 bi-hand-thumbs-down-fill text-danger">{all_time_dislikes}</p>*/}
                    {/*</Col>*/}
                </Row>
            </Col>
        </Row>
        <FollowerModal show={showFollowerModal} setShow={handleFollowerModal}/>
        <FollowingModal show={showFollowingModal} setShow={handleFollowingModal}/>
    </div>
}

export default ProfileHeader;
