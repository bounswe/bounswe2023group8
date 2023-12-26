import React, {useEffect, useState} from "react";
import {Col, Row} from "react-bootstrap";
import SpanWithOnClick from "../shared/SpanWithOnClick/SpanWithOnClick";
import FollowerModal from "../Follow/Follower/FollowerModal";
import FollowingModal from "../Follow/Following/FollowingModal";
import {useReportAnIssue} from "../../hooks/useModeration";
import {useAuth} from "../../contexts/AuthContext";
import {
    useDeleteProfilePicture,
    useFollowUser,
    useGetFollowers,
    useGetFollowings,
    useUnfollowUser,
    useUploadProfilePicture
} from "../../hooks/useUser";
import {useToastContext} from "../../contexts/ToastContext";
import PictureUploadModal from "./PictureUploadModal";

type ProfileHeaderProps = {
    user: {
        id: number,
        name: string,
        username: string,
        followers: number,
        following: number,
        pictureUrl: string
    },
    reputation: string;
    style: object,
    className: string,
    getProfileData: () => void,
};

const ProfileHeader = ({
                           user: {id, name, username, followers, following, pictureUrl},
                           reputation,
                           style,
                           className,
                           getProfileData
                       }: ProfileHeaderProps) => {
    const [showFollowerModal, setShowFollowerModal] = useState(false);
    const [showFollowingModal, setShowFollowingModal] = useState(false);
    const [showPictureUploadModal, setShowPictureUploadModal] = useState(false);
    const [reportReason, setReportReason] = useState("");
    const [showReport, setShowReport] = useState(false);

    const {axiosInstance, userData} = useAuth();

    const {mutate: reportAnIssue} = useReportAnIssue({
        axiosInstance,
        issue: {
            entityId: id,
            entityType: "user",
            reason: reportReason,
        },
    });

    const reportUser = () => {
        reportAnIssue({
            axiosInstance,
            issue: {
                entityId: id,
                entityType: "user",
                reason: reportReason,
            },
        });
    };

    const handleFollowerModal = () => {
        setShowFollowerModal(!showFollowerModal);
    };

    const handleFollowingModal = () => {
        setShowFollowingModal(!showFollowingModal);
    };

    const { toastState, setToastState } = useToastContext();

    const {mutate: getFollowers, data: followersData} = useGetFollowers({})
    const {mutate: getFollowings, data: followingsData} = useGetFollowings({})
    const {mutate: followUser} = useFollowUser({
        config:{
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Followed Successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Followed Successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Followed Successfully!"
                })), 6000);

                getFollowings({
                    axiosInstance,
                    id
                })
                getProfileData();
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Could not follow. You are already following this user!!"
                });
                setToastState([
                    ...tempState,
                    {message: "Could not follow. You are already following this user!", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Could not follow. You are already following this user!"
                })), 6000);
            }
        }
    })
    const {mutate: unfollowUser} = useUnfollowUser({
        config:{
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Unfollowed Successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Unfollowed Successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Unfollowed Successfully!"
                })), 6000);


                getFollowings({
                    axiosInstance,
                    id
                })
                getProfileData()
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Could not unfollow. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Could not unfollow. Try again later!", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Could not unfollow. Try again later!"
                })), 6000);
            }
        }
    })

    useEffect(() =>{
        getFollowers({
            axiosInstance,
            id,
        })
        getFollowings({
            axiosInstance,
            id
        })
    }, [])

    const handleUnfollow = (id: number) => {
        unfollowUser({
            axiosInstance,
            id
        })
    }

    const handleFollow = (id: number) => {
        followUser({
            axiosInstance,
            id
        })
    }

    return (
        <div
            style={{
                background: "#EEF0EB",
                display: "flex",
                alignItems: "center",
            }}
            className="justify-content-between flex-row"
        >
            <div className="d-flex align-items-center col-7">
                <div className={`card mt-3 mb-1 col-8 ${className}`} style={style}>
                    <Row className="g-0">
                        <Col
                            className="col-4 justify-content-center align-content-center my-4"
                            style={{maxHeight: "80px", maxWidth: "80px"}}
                        >
                            {pictureUrl
                                ?
                                <img src={pictureUrl} className="rounded-circle img-fluid object-fit-cover h-100 w-100" width={64} height={64}
                                     style={{borderRadius: '50%'}} alt="PP goes here"
                                    onClick={() => setShowPictureUploadModal(!showPictureUploadModal)}/>
                                : <h1 onClick={() => setShowPictureUploadModal(!showPictureUploadModal)}
                                      className="bi bi-person-circle display-1 mx-4"
                                      style={{cursor: 'pointer'}}></h1>}
                            {userData.id != id
                            ? <button className="btn btn-sm WA-theme-bg-main WA-theme-light mt-1 w-100"
                                     onClick={ ()=> handleFollow(id)}>
                                    Follow
                            </button>
                            : <></>
                            }

                        </Col>
                        <Col className="col-8">
                            <Row className="card-body">
                                <Col className="col-10 m-auto">
                                    <h5 className="card-title" style={{fontSize: "2rem"}}>
                                        {name}
                                    </h5>
                                    <p
                                        className="card-text text-body-secondary"
                                        style={{fontSize: "1.5rem"}}
                                    >
                                        @{username}
                                    </p>
                                    <Row className="justify-content-between">
                                        <Col className="card-text" style={{fontSize: "1.2rem"}}>
                                            <SpanWithOnClick
                                                className={""}
                                                text={`${followers} followers`}
                                                onClick={handleFollowerModal}
                                            />
                                        </Col>
                                        <Col className="card-text" style={{fontSize: "1.2rem"}}>
                                            <SpanWithOnClick
                                                className={""}
                                                text={`${following} following`}
                                                onClick={handleFollowingModal}
                                            />
                                        </Col>
                                    </Row>
                                </Col>
                            </Row>
                        </Col>
                    </Row>

                    <FollowerModal show={showFollowerModal}
                                   setShow={handleFollowerModal}
                                   followerData={followersData}
                                   handleFollow={handleFollow}/>
                    <FollowingModal
                        show={showFollowingModal}
                        setShow={handleFollowingModal}
                        followingData={followingsData}
                        handleUnfollow={handleUnfollow}
                        handleFollow={handleFollow}
                    />
                </div>
                {reputation
                ? <div className="card-text rounded-5 col-2" style={{
                    padding: "15px",
                    fontSize: "1.1rem",
                    background: "rgb(136, 154, 186)",
                    color: "white",
                    display: "flex",
                    flexDirection: "column",
                    alignItems: "center"
                }}>
                    <p>Reputation:</p>
                    <p style={{fontSize: "1.5rem", margin: "0px"}}>{reputation}</p>
                </div>
                : <></>
                }
            </div>
            {userData.id != id
                ? <Col className="d-flex col-5">
                    <div
                        className="mx-2 my-3 w-75 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
                        {showReport ? (
                            <>
                                <input
                                    type="text"
                                    className="form-control m-4 "
                                    placeholder="Please write a reason"
                                    onChange={(e) => setReportReason(e.target.value)}
                                ></input>
                                <div className="d-flex mx-3">
                                    <button onClick={() => reportUser()} className="btn">
                                        Submit
                                    </button>
                                    <button
                                        onClick={() => setShowReport(!showReport)}
                                        className="btn"
                                    >
                                        Close
                                    </button>
                                </div>
                            </>
                        ) : (
                            <>
                                <button
                                    onClick={() => setShowReport(!showReport)}
                                    className="btn mx-3 rounded-5"
                                >
                                    Report
                                </button>
                            </>
                        )}
                    </div>
                </Col>
                : <></>
            }
            <PictureUploadModal show={showPictureUploadModal}
                                handleShow={() => setShowPictureUploadModal(!showPictureUploadModal)}
                                getProfile={getProfileData}/>
        </div>
    );
};

export default ProfileHeader;
