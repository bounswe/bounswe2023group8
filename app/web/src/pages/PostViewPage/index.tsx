import React, {useEffect, useState} from 'react';
import {useParams} from 'react-router-dom';
import DetailedPostCard from '../../components/Post/DetailedPostCard';
import {useGetPost} from "../../hooks/usePost";
import {useAuth} from "../../contexts/AuthContext";
import {useCreateComment, useDeleteComment, useGetComments} from "../../hooks/useComment";

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

    const handleCreateCommentInputChange = (
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
                <div className="col-12 d-flex flex-column">
                    <div className="card-body overflow-y-auto">
                        {post && <DetailedPostCard
                            post={post}
                            handleCreateCommentCardDisplay={handleCreateCommentCardDisplay}
                            commentContent={commentContent}
                            handleCreateCommentInputChange={handleCreateCommentInputChange}
                            handleCommentSubmit={handleCommentSubmit}
                            comments={comments}
                            deleteComment={deleteComment}
                            showCreateCommentCard={showCreateCommentCard}
                        />}
                    </div>
                </div>
            </div>
        </>
    );
}

export default PostViewPage;
