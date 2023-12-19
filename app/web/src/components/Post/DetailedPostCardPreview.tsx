import React from 'react';
import {Link} from "react-router-dom";
import Label from "../Label/Label";
import {format} from "date-fns";

export type DetailedPostCardPreviewProps = {
    interestAreaId: string;
    interestAreaTitle: string;
    enigmaUserName: string;
    enigmaUserId: string;
    enigmaUserUsername: string;
    title: string;
    label: string;
    sourceLink: string;
    content: string;
}

const createdAtString = format(new Date(), "PPpp");

const DetailedPostCardPreview = ({
                                     content,
                                     enigmaUserId,
                                     enigmaUserName,
                                     enigmaUserUsername,
                                     interestAreaId,
                                     interestAreaTitle,
                                     label,
                                     sourceLink,
                                     title
                                 }: DetailedPostCardPreviewProps) => {
    return (
        <div className="card WA-theme-bg-regular rounded-4 mb-3 mt-4">
            <div className="d-flex justify-content-between align-items-center">
                <span className="d-flex">
                    <span style={{position: "relative", top: '-0.5em'}}>
                        <img alt="Bunch Icon" src="/assets/theme/images/Bunch.png"></img>
                    </span>
                    <span className="flex-column">
                        <div>
                            <Link to={`/interest-area/${interestAreaId}`}
                                  style={{textDecoration: 'none'}}
                                  className="fs-4 fw-bold WA-theme-dark ">
                                    {interestAreaTitle}
                            </Link>
                        </div>
                        <div className="d-inline-flex">
                            <img alt="Profile picture" src="/assets/PlaceholderProfile.png" width="64" height="64"/>
                            <div className="">
                                <div className="fw-bold fs-6 WA-theme-dark">{enigmaUserName}</div>
                                <div className="d-flex justify-content-between">
                                    <div className="d-flex">
                                        <Link to={`/profile/${enigmaUserId}`}
                                              style={{textDecoration: 'none'}}
                                              className="WA-theme-main">
                                            {` @${enigmaUserUsername}`}
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
            </div>
            <div className="card WA-theme-bg-light rounded-4 ms-4 m-1 ">
                <img alt="Bookmark Icon" src="/assets/theme/images/FactCheck=False.png"
                     width="64" height="64"
                     style={{position: "absolute", top: '-0.66em', left: '-0.60em'}}
                />
                <div className="row g-0 ms-4">
                    <div className="col-12">
                        <div className="card-body">
                            <div className="d-flex justify-content-between">
                                <div style={{textDecoration: 'none'}}
                                      className="card-title truncate-text-2 WA-theme-dark fs-5 fw-bold">{title}</div>
                                <img alt="Geolocation Button" src="/assets/theme/icons/GeolocationIcon.png" width="32"
                                     height="32"
                                />
                            </div>
                            <Label className="" label={label}/>
                            <Link to={sourceLink} className="truncate-text-2 WA-theme-main fw-bold mt-1">
                                {sourceLink}
                            </Link>
                            <div className="card-title truncate-text-4 WA-theme-dark">{content}</div>
                            <div className="mb-2">{`Date: ${createdAtString}`}</div>
                            <span className="m-3">
                                <img alt="upvote icon" src="/assets/theme/icons/Upvote.png" width="32" height="32"
                                     style={{cursor: 'pointer'}} />
                                <span className="WA-theme-positive fw-bold fs-6 me-5"> 0 </span>
                                <img alt="downvote icon" src="/assets/theme/icons/Downvote.png" width="32" height="32"
                                     style={{cursor: 'pointer'}} />
                                <span className="WA-theme-negative fw-bold fs-6"> 0 </span>
                            </span>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    );
}

export default DetailedPostCardPreview;
