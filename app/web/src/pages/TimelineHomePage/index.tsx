import React, {useEffect} from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import {useGetUserTimeline} from "../../hooks/useTimeline";
import {useAuth} from "../../contexts/AuthContext";
import {Post} from "../InterestAreaViewPage";


const TimelineHomePage: React.FC = () => {
    const {axiosInstance} = useAuth();

    const{ mutate, data, isSuccess} = useGetUserTimeline({});

    useEffect(() => {
        mutate({
            axiosInstance,
        })
    },[])

    return (
        <div className="container mt-3">
            {isSuccess
                ? <div>
                    {data.posts.map((post: Post, index: number) => {
                    return <PostPreviewCard key={index}
                                            id={post.id}
                                            enigmaUser={post.enigmaUser}
                                            interestArea={post.interestArea}
                                            sourceLink={post.sourceLink}
                                            title={post.title}
                                            wikiTags={post.wikiTags}
                                            label={post.label}
                                            content={post.content}
                                            geolocation={post.geolocation}
                                            createTime={post.createTime}
                                            upvoteCount={post.upvoteCount}
                                            downvoteCount={post.downvoteCount}/>
                })
                    }
                </div>
                : <h1>Waiting for data...</h1>
            }

        </div>
    );
};

export default TimelineHomePage;