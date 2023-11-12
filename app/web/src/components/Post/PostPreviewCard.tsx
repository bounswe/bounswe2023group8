import React from 'react';
import {format} from 'date-fns';
import Tag from "../Tag/Tag";

type PostPreviewCardProps = {
    post: {
        id: number,
        source_link: string,
        content: string,
        created_at: string//"2023-10-25 10:30:00"
    },
    userName: string | undefined,
    interestAreas: {
        id: number,
        area_name: string,
    }[]
}

const PostPreviewCard = ({
                             interestAreas,
                             post: {content, created_at, id, source_link},
                             userName
                         }: PostPreviewCardProps) => {

    const createdAtString = format(new Date(created_at), "dd.MM.yyyy");

    return <div className="card mb-3 bg-primary-subtle">
        <div className="row g-0">
            <div className="col-9">
                <div className="card-body">
                    <h6 className="card-title truncate-text-4">{content}</h6>
                    <p><a href={source_link} className="link-primary">{source_link}</a></p>
                    <p className="card-text justify-content-between d-flex">
                        <small className="text-body-secondary">Created by {userName}</small>
                        <small className="text-body-secondary">{createdAtString}</small>
                    </p>
                </div>
            </div>
            <div className="col-3 container d-flex justify-content-start p-1 m-0 ">
                <div className="vr my-3 col-1"></div>
                <div className="mx-auto align-self-center overflow-y-auto" style={{maxHeight: '200px'}}>
                    {interestAreas.map((area) =>
                        <Tag className={""} key={`${id}-${area.id}`} name={area.area_name}/>
                    )}
                </div>
            </div>
        </div>
    </div>
}

export default PostPreviewCard;
