import React, {useState} from 'react';
import {EnigmaUser} from "../../pages/InterestAreaViewPage";
import {Link, useNavigate} from "react-router-dom";
import {format, formatDistance} from "date-fns";
import {useAuth} from "../../contexts/AuthContext";
import {DeleteCommentProps, useUpdateComment} from "../../hooks/useComment";
import {UseMutateFunction} from "react-query";

export type Comment = {
    id: number;
    postId: number;
    enigmaUser: EnigmaUser;
    content: string;
    createTime: string;
}

export type CommentCardProps = {
    comment: Comment;
    deleteComment: UseMutateFunction<any, unknown, DeleteCommentProps, unknown>;
}

const CommentCard = ({comment: {content, createTime, id, postId, enigmaUser}, deleteComment}: CommentCardProps) => {

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

    const {userData} = useAuth();
    const [isAskingForDelete, setIsAskingForDelete] = useState(false);
    const [isEditing, setIsEditing] = useState(false);
    const [editedContent, setEditedContent] = useState(content);
    const [originalContent, setOriginalContent] = useState(content);

    const {axiosInstance} = useAuth();
    const {mutate: updateComment} = useUpdateComment({});


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
        setEditedContent(value);
    };

    const handleEditSubmit = (event: React.FormEvent) => {
        event.preventDefault();
        updateComment({
            postId: postId,
            data: {
                commentId: id,
                content: editedContent
            },
            axiosInstance,
        });
        setOriginalContent(editedContent);
        setIsEditing(!isEditing);
    }

    const handleCancelEdit = (event: React.FormEvent) => {
        event.preventDefault();
        setEditedContent(originalContent);
        setIsEditing(!isEditing)
    }

    const handleDelete = (event: React.FormEvent) => {
        event.preventDefault()
        deleteComment({
            postId: postId,
            commentId: id,
            axiosInstance: axiosInstance
        })
    }


    return <div className="">
        <div className="card rounded-3 WA-theme-bg-regular m-2 d-flex flex-row">
            <div className="col-3 flex-row d-flex">
                <span className="col-4">
                    {enigmaUser.pictureUrl
                        ? <img alt="profile picture" src={enigmaUser.pictureUrl} width="64" height="64"
                               className="rounded-circle img-fluid object-fit-cover m-2 border-2"
                        />
                        : <img alt="Profile picture" src="/assets/PlaceholderProfile.png" width="64" height="64"/>
                    }
                </span>
                <span className="my-2 mx-2 col-8">
                    <div>{enigmaUser.name}</div>
                    <Link to={`/profile/${enigmaUser.id}`}
                          style={{textDecoration: 'none'}}
                          className="WA-theme-main">@{enigmaUser.username}</Link>
                    <div className="">{createdAtString}</div>
                </span>
            </div>

            {isEditing
                ? <div className=" card-body WA-theme-bg-light m-2 p-2 col-9 rounded-3">
                    <form onSubmit={handleEditSubmit}>
                        <div className="mx-1 d-flex flex-row align-items-center justify-content-center ">
                            <div className="d-flex col-10">
                        <textarea
                            id="content"
                            className="form-control WA-theme-bg-light"
                            rows={3}
                            name="content"
                            value={editedContent}
                            onChange={handleInputChange}
                        />
                            </div>
                            <div className="d-flex mx-2 center d-flex flex-column">
                                <button type="submit" className="btn btn-sm WA-theme-bg-main WA-theme-light my-1 ">
                                    Comment
                                </button>
                                <button onClick={handleCancelEdit}
                                        className="btn btn-sm WA-theme-bg-dark WA-theme-light my-1 ">
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                : <div className=" card-body WA-theme-bg-light m-2 p-2 col-9 rounded-3">
                    <p>{editedContent}</p>
                    {enigmaUser.id == userData.id
                        ? <div className="d-flex flex-row justify-content-end mt-2 mb-0">
                            {isAskingForDelete
                                ? <div className="WA-theme-negative">
                                    Are you sure you want to delete this comment?
                                    <button onClick={handleDelete}
                                            className="btn btn-sm WA-theme-bg-main WA-theme-light mx-1">
                                        Delete
                                    </button>
                                    <button className="btn btn-sm WA-theme-bg-dark WA-theme-light mx-1"
                                            onClick={() => {
                                                setIsAskingForDelete(!isAskingForDelete)
                                            }}>
                                        Cancel
                                    </button>
                                </div>
                                : <div>
                                <span onClick={() => {
                                    setIsEditing(!isEditing)
                                }}
                                      style={{cursor: 'pointer'}} className="mx-2">
                                    <img alt="Edit" src="/assets/theme/icons/EditIcon.png"
                                         style={{width: '1.25em', height: '1.25em'}} className="mb-1"/>
                                </span>
                                    <span onClick={() => {
                                        setIsAskingForDelete(!isAskingForDelete)
                                    }}
                                          style={{cursor: 'pointer'}} className="mx-2">
                                    <img alt="Edit" src="/assets/theme/icons/Type=Delete.png"
                                         style={{width: '1.25em', height: '1.25em'}} className="mb-1"/>
                                </span>
                                </div>
                            }
                        </div>
                        : <></>}
                </div>
            }
        </div>
    </div>
}

export default CommentCard;
