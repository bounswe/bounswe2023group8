import React, {useEffect, useState} from 'react';
import {useParams} from 'react-router-dom';
import DetailedPostCard from '../../components/Post/DetailedPostCard';
import {useGetPost} from "../../hooks/usePost";
import {useAuth} from "../../contexts/AuthContext";
import CommentCreateCard from "../../components/Comment/CommentCreateCard";
import {useCreateComment, useDeleteComment, useGetComments} from "../../hooks/useComment";
import CommentCard, {Comment} from "../../components/Comment/CommentCard";

const PostViewPage = () => {
    const {postId} = useParams();

    const {axiosInstance} = useAuth();
    const {mutate: getPost, data: post} = useGetPost({});
    const {mutate: getComments, data: comments} = useGetComments({});
    const {mutate: createComment} = useCreateComment({config: {
            onSuccess: (data: any) => {
                getComments({
                    axiosInstance: axiosInstance,
                    postId: postId || "-1",
                })
            }
        }});
    const {mutate: deleteComment} = useDeleteComment({
        config: {
            onSuccess: (data: any) => {
                getComments({
                    axiosInstance: axiosInstance,
                    postId: postId || "-1",
                })
            }
        }
    });

    const [showCreateCommentCard, setShowCreateCommentCard] = useState(false);
    const [commentContent, setCommentContent] = useState("");

    const handleCreateCommentCardDisplay = () => {
        setShowCreateCommentCard(!showCreateCommentCard);
    }

    const handleInputChange = (
        e:
            | React.ChangeEvent<HTMLInputElement>
            | React.ChangeEvent<HTMLSelectElement>
            | React.ChangeEvent<HTMLTextAreaElement>
    ) => {
        const {name, value} = e.target as typeof e.target & {
            value: string;
            name: string;
        };
        setCommentContent(value);
    };

    const handleCommentSubmit = (event: React.FormEvent) => {
        event.preventDefault();
        createComment({
            axiosInstance,
            data: {content: commentContent},
            postId: postId || "-1",
        });
        setCommentContent("");
    };

    useEffect(() => {
        getPost({
            axiosInstance: axiosInstance,
            id: postId || "-1",
        })
        getComments({
            axiosInstance: axiosInstance,
            postId: postId || "-1",
        })
    }, [])


    return (
        <>
            <div className="d-flex">
                <div className="col-8 d-flex flex-column">
                    <div className="card-body overflow-y-auto">
                        {post && <DetailedPostCard
                            post={post}
                            handleCreateCommentCardDisplay={handleCreateCommentCardDisplay}
                        />}
                    </div>
                    <div className="">
                        {showCreateCommentCard &&
                            <CommentCreateCard content={commentContent} handleSubmit={handleCommentSubmit}
                                               handleInputChange={handleInputChange}/>
                        }
                        {comments
                            ? <div className="overflow-y-scroll h-75">
                                {[...comments].reverse().map((comment: Comment) => {
                                    return <CommentCard key={comment.id} comment={comment} deleteComment={deleteComment}/>
                                })}
                            </div>
                            : <></>
                        }
                    </div>
                </div>
                <div className="col-4">
                    Annotations go into this div
                </div>
            </div>
        </>
    );
}

export default PostViewPage;
