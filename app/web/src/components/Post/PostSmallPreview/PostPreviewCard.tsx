import React from 'react';
import {format} from 'date-fns';
import Tag from "../../Tag/Tag";

type PostPreviewCardProps = {
    post: {
        id: number,
        sourceLink: string,
        title: string,
        content: string,
        createTime: string//"2023-10-25 10:30:00"
    },
    userName: string | undefined,
    tags: {
        id: number,
        label: string,
    }[]
}

const PostPreviewCard = ({
                             tags,
                             post: {title, createTime, id, sourceLink, content},
                             userName
                         }: PostPreviewCardProps) => {

    const createdAtString = format(new Date(createTime), "dd.MM.yyyy");

    return <div className="card mb-3 bg-primary-subtle">
        <div className="row g-0">
            <div className="col-9">
                <div className="card-body">
                    <h5 className="card-title truncate-text-4">{title}</h5>
                    <div className="card-title truncate-text-4">{content}</div>
                    <p><a href={sourceLink} className="link-primary">{sourceLink}</a></p>
                    <p className="card-text justify-content-between d-flex">
                        <small className="text-body-secondary">Created by {userName}</small>
                        <small className="text-body-secondary">{createdAtString}</small>
                    </p>
                </div>
            </div>
            <div className="col-3 container d-flex justify-content-start p-1 m-0 ">
                <div className="vr my-3 col-1"></div>
                <div className="mx-auto align-self-center overflow-y-auto" style={{maxHeight: '200px'}}>
                    {tags.map((tag) =>
                        <Tag className={""} key={`${id}-${tag.id}`} name={tag.label}/>
                    )}
                </div>
            </div>
        </div>
    </div>
}

export default PostPreviewCard;
