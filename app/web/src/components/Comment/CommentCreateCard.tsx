import React from 'react';

export type CreateCommentFormData = {
    content: string;
}

export type CommentCreateCardProps = {
    handleSubmit: (_: React.FormEvent) => void;
    handleInputChange: (
        e:
            | React.ChangeEvent<HTMLInputElement>
            | React.ChangeEvent<HTMLSelectElement>
            | React.ChangeEvent<HTMLTextAreaElement>
    ) => void;
    content: string;
}

const CommentCreateCard = ({content, handleInputChange, handleSubmit}: CommentCreateCardProps) => {

    return (
        <div className="card WA-theme-bg-regular">
            <form onSubmit={handleSubmit}>
                <div className="mx-1 d-flex flex-row align-items-center justify-content-center ">
                    <div className="my-3 d-flex col-10">
                        <textarea
                            id="content"
                            className="form-control WA-theme-bg-light"
                            name="content"
                            value={content}
                            onChange={handleInputChange}
                        />
                    </div>
                    <div className="d-flex mx-2 center">
                        <button type="submit" className="btn WA-theme-bg-main text-white ">
                            Comment
                        </button>
                    </div>
                </div>
            </form>
        </div>
    );
}

export default CommentCreateCard;
