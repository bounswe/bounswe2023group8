import React, {useEffect, useState} from "react";
import {format} from "date-fns";
import Tag from "../Tag/Tag";
import {Post} from "../../pages/InterestAreaViewPage";
import LocationViewer from "../Geolocation/LocationViewer";
import {useAuth} from "../../contexts/AuthContext";
import {Link, useNavigate, useParams} from "react-router-dom";
import Label from "../Label/Label";
import {useDownvoteSpot, useGetSpotVotes, useUnvoteSpot, useUpvoteSpot} from "../../hooks/useSpotVotes";
import {useDeletePost} from "../../hooks/usePost";

export type DetailedPostCardProps = {
    post: Post;
    handleCreateCommentCardDisplay: () => void;
}

const DetailedPostCard = (props: DetailedPostCardProps) => {
    const [locationModalShow, setLocationModalShow] = useState(false);
    const handleLocationModalShow = () => {
        setLocationModalShow(!locationModalShow);
    }
    const {
        post: {
            content,
            createTime,
            enigmaUser,
            geolocation,
            id,
            interestArea,
            label,
            sourceLink,
            title,
            wikiTags,
            upvoteCount,
            downvoteCount,
        },
        handleCreateCommentCardDisplay,
    } = props;

    const {userData, axiosInstance} = useAuth();
    const {postId} = useParams();
    const [upvotes, setUpvotes] = useState(upvoteCount);
    const [downvotes, setDownvotes] = useState(downvoteCount);
    const [isDeleting, setIsDeleting] = useState(false);

    const navigate = useNavigate();
    const {mutate: deleteSpot} = useDeletePost({
        config: {
            onSuccess: (data: any) => {
                navigate(`/interest-area/${interestArea.id}`);
            }
        }
    })

    const handleDeleteSpot = (event: React.FormEvent) => {
        event.preventDefault()
        deleteSpot({
            id: id.toString(),
            axiosInstance: axiosInstance
        })
    }

    const {mutate: getSpotVotes, data: votesOnSpot} = useGetSpotVotes({});
    const {mutate: upvoteSpot} = useUpvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];
                if (vote && !vote.isUpvote) {
                    setDownvotes(downvotes - 1);
                    setUpvotes(upvotes + 1);
                } else {
                    setUpvotes(upvotes + 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        }
    });
    const {mutate: downvoteSpot} = useDownvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];

                if (vote && vote.isUpvote) {
                    console.log("upvoted before. Can downvote");
                    setUpvotes(upvotes - 1);
                    setDownvotes(downvotes + 1);
                } else {
                    console.log("not voted before. Can downvote");
                    setDownvotes(downvotes + 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        }
    });
    const {mutate: unvoteSpot} = useUnvoteSpot({
        config: {
            onSuccess: (data: any) => {
                const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
                    return datum.enigmaUser.id == userData.id;
                })[0];

                if (vote.isUpvote) {
                    console.log("upvoted before. Can downvote");
                    setUpvotes(upvotes - 1);
                } else {
                    console.log("not voted before. Can downvote");
                    setDownvotes(downvotes - 1);
                }

                getSpotVotes({
                    axiosInstance: axiosInstance,
                    id: postId || "1",
                })
            }
        }
    });


    useEffect(() => {
        getSpotVotes({
            axiosInstance: axiosInstance,
            id: postId || "1",
        })
    }, [])

    const handleUpvote = () => {
        const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
            return datum.enigmaUser.id == userData.id;
        })[0];
        if (vote && vote.isUpvote) {
            unvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })
        } else if (vote && !vote.isUpvote) {
            upvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })

        } else {
            upvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })
        }
    }

    const handleDownvote = () => {
        const vote = votesOnSpot.filter((datum: { enigmaUser: { id: number; }; }) => {
            return datum.enigmaUser.id == userData.id;
        })[0];
        if (vote && !vote.isUpvote) {
            unvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })
        } else if (vote && vote.isUpvote) {
            downvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })
        } else {
            downvoteSpot({
                axiosInstance: axiosInstance,
                id: postId || "1",
            })
        }
    }

    const createdAtString = format(new Date(createTime), "PPpp");

    return (
        <div className="card WA-theme-bg-regular rounded-4 mb-3 mt-4">
            <div className="d-flex justify-content-between align-items-center">
                <span className="d-flex">
                    <span style={{position: "relative", top: '-0.5em'}}>
                        <img alt="Bunch Icon" src="/assets/theme/images/Bunch.png"></img>
                    </span>
                    <span className="flex-column">
                        <div>
                            <Link to={`/interest-area/${interestArea.id}`}
                                  style={{textDecoration: 'none'}}
                                  className="fs-4 fw-bold WA-theme-dark">
                                    {interestArea.title}
                            </Link>
                        </div>
                        <div className="d-inline-flex">
                            {enigmaUser.pictureUrl
                                ? <img alt="profile picture" src={enigmaUser.pictureUrl} width="64" height="64"
                                       className="rounded-circle img-fluid object-fit-cover m-2"
                                />
                                :
                                <img alt="Profile picture" src="/assets/PlaceholderProfile.png" width="64" height="64"/>
                            }
                            <div className="my-3 mx-2">
                                <div className="fw-bold fs-6 WA-theme-dark">{enigmaUser.name}</div>
                                <div className="d-flex justify-content-between">
                                    <div className="d-flex">
                                        <Link to={`/profile/${enigmaUser.id}`}
                                              style={{textDecoration: 'none'}}
                                              className="WA-theme-main">
                                            {` @${enigmaUser.username}`}
                                        </Link>
                                    </div>
                                    {/*<div className="d-flex">*/}
                                    {/*    <button className="btn btn-outline-primary">Follow</button>*/}
                                    {/*</div>*/}
                                </div>
                            </div>
                        </div>
                    </span>
                </span>
                <span className="mx-3">
                    {enigmaUser.id == userData.id
                        ?
                        <span className="d-flex">
                            {!isDeleting
                                ? <div>
                                    <Link to={`/update_post/${postId}`}
                                          state={{
                                              post: {
                                                  content: content,
                                                  createTime: createTime,
                                                  enigmaUser: enigmaUser,
                                                  geolocation: geolocation,
                                                  id: id,
                                                  interestArea: interestArea,
                                                  label: label,
                                                  sourceLink: sourceLink,
                                                  title: title,
                                                  wikiTags: wikiTags,
                                                  upvoteCount: upvoteCount,
                                                  downvoteCount: downvotes,
                                              }
                                          }}
                                          style={{textDecoration: 'none'}}
                                          className="btn WA-theme-bg-main WA-theme-light mx-1">Edit
                                        Spot</Link>
                                    <button className="btn WA-theme-bg-negative WA-theme-light mx-1"
                                            onClick={() => {
                                                setIsDeleting(!isDeleting)
                                            }}>
                                        Delete Spot
                                    </button>
                                </div>
                                : <div>
                                    Are you sure?
                                    <button className="btn WA-theme-bg-main WA-theme-light mx-1"
                                            onClick={handleDeleteSpot}>
                                        Delete Spot
                                    </button>
                                    <button className="btn WA-theme-bg-dark WA-theme-light mx-1"
                                            onClick={() => {
                                                setIsDeleting(!isDeleting)
                                            }}>
                                        Cancel
                                    </button>
                                </div>
                            }
                        </span>
                        : <></>}
                </span>
            </div>
            <div className="card WA-theme-bg-light rounded-4 ms-4 m-2 ">
                <img alt="Bookmark Icon" src="/assets/theme/images/FactCheck=False.png"
                     width="64" height="64"
                     style={{position: "absolute", top: '-0.66em', left: '-0.60em'}}
                />
                <div className="row g-0 ms-4">
                    <div className="col-9">
                        <div className="card-body">
                            <div className="d-flex justify-content-between">
                                <Link to={`/posts/${id}`}
                                      style={{textDecoration: 'none'}}
                                      className="card-title truncate-text-2 WA-theme-dark fs-5 fw-bold">{title}</Link>
                                <img alt="Geolocation Button" src="/assets/theme/icons/GeolocationIcon.png" width="32"
                                     height="32"
                                     onClick={handleLocationModalShow}
                                />
                            </div>
                            <Label className="" label={label}/>
                            <Link to={sourceLink} className="truncate-text-2 WA-theme-main fw-bold mt-1">
                                {sourceLink}
                            </Link>
                            <div className="card-title truncate-text-4 WA-theme-dark">{content}</div>
                            <div className="mb-2">{`Date: ${createdAtString}`}</div>
                            <span className="m-3 d-flex justify-content-between">
                                <span className="d-flex">
                                    <img alt="upvote icon" src="/assets/theme/icons/Upvote.png" width="32" height="32"
                                         style={{cursor: 'pointer'}} onClick={handleUpvote}/>
                                    <span className="WA-theme-positive fw-bold fs-6 me-5"> {upvotes} </span>
                                    <img alt="downvote icon" src="/assets/theme/icons/Downvote.png" width="32"
                                         height="32"
                                         style={{cursor: 'pointer'}} onClick={handleDownvote}/>
                                    <span className="WA-theme-negative fw-bold fs-6"> {downvotes} </span>
                                    <span onClick={handleCreateCommentCardDisplay} style={{cursor: 'pointer'}}><
                                        i className="bi bi-chat-left-text-fill WA-theme-main fs-4 ms-5"></i>
                                    </span>

                                </span>
                            </span>
                        </div>

                    </div>
                    <div className="col-3 container d-flex justify-content-start p-1 m-0 ">
                        <div className="vr my-3 col-1"></div>
                        <div
                            className="mx-auto flex-fill align-self-center overflow-y-auto px-3 my-1"
                            style={{maxHeight: "200px"}}
                        >
                            {wikiTags.map((tag: any) => (
                                <Tag className="" key={`${id}-${tag.id}`} label={tag.label}/>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
            <LocationViewer showLocationViewerModal={locationModalShow}
                            setShowLocationViewerModal={handleLocationModalShow}
                            locationData={geolocation}></LocationViewer>
        </div>
    );
}

export default DetailedPostCard;
