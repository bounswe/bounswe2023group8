import React from "react";
import {format, formatDistance} from "date-fns";
import Tag from "../../Tag/Tag";
import {Post} from "../../../pages/InterestAreaViewPage";
import {Link} from "react-router-dom";
import Label from "../../Label/Label";

type PostPreviewCardProps = Post;

const PostPreviewCard = ({
                             id,
                             enigmaUser,
                             interestArea,
                             sourceLink,
                             title,
                             wikiTags,
                             label,
                             content,
                             createTime, upvoteCount, downvoteCount
                         }: PostPreviewCardProps) => {
    let createdAtString;
    const createdDate = new Date(createTime);
    if ((new Date().getTime() - createdDate.getTime()) / (1000 * 60 * 60 * 24) < 1) {
        createdAtString = formatDistance(
            createdDate,
            new Date(),
            {addSuffix: true}
        )
    } else {
        createdAtString = format(new Date(createTime), "dd.MM.yyyy");
    }

    const likes =  upvoteCount - downvoteCount;

    function extractDomain(url: string): string | null {
        const regex = /https?:\/\/(www\.)?(.+?)\./;
        const match = url.match(regex);
        return match ? (match[2].charAt(0).toUpperCase() + match[2].slice(1)) : url;
    }

    return (
        <div className="card WA-theme-bg-regular rounded-4 mb-3">
            <div className="justify-content-between d-flex d-inline-flex">
                <span className="d-flex">
                    <span style={{position:"relative", top: '-0.5em'}}>
                        <img alt="Bunch Icon" src="/assets/theme/images/Bunch.png"></img>
                    </span>
                    <span>
                        <Link to={`/interest-area/${interestArea.id}`}
                              style={{textDecoration: 'none'}}
                              className="fs-4 fw-bold WA-theme-dark">
                                {interestArea.title}
                        </Link>
                        <div className="WA-theme-dark" >Spotted by
                            <Link to={`/profile/${enigmaUser.id}`}
                                  style={{textDecoration: 'none'}}
                                  className="WA-theme-main">
                                {` @${enigmaUser.username}`}
                            </Link>
                            <i className="bi bi-dot fs-6"></i>
                            <span>{` ${createdAtString}`}</span>
                        </div>
                    </span>
                </span>
                <span className="m-3">
                    <img alt="upvote icon" src="/assets/theme/icons/Upvote.png" width="32" height="32" />
                    {likes < 0
                        ? <span className="WA-theme-negative fw-bold fs-6"> {-likes} </span>
                        : <span className="WA-theme-positive fw-bold fs-6"> {likes} </span>
                    }
                    <img alt="downvote icon" src="/assets/theme/icons/Downvote.png" width="32" height="32"/>
                </span>
            </div>
            <div className="card WA-theme-bg-light rounded-4 ms-4 m-1 ">
                <img alt="Bookmark Icon" src="/assets/theme/images/FactCheck=False.png"
                     width="64" height="64"
                     style={{position: "absolute", top: '-0.66em', left: '-0.60em'}}
                />
                <div className="row g-0 ms-4">
                    <div className="col-9">
                        <div className="card-body">
                            <Link to={`/posts/${id}`}
                                  style={{textDecoration: 'none'}}
                                  className="card-title truncate-text-2 WA-theme-dark fs-5 fw-bold">{title}</Link>
                            <Label className="" label={label}/>
                            <Link to={sourceLink} className="truncate-text-2 WA-theme-main fw-bold mt-1">
                                {extractDomain(sourceLink)}
                            </Link>
                            <div className="card-title truncate-text-4 WA-theme-dark">{content}</div>
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
        </div>
    );
};

export default PostPreviewCard;
