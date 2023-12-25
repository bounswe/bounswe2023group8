import React, {useEffect, useState} from 'react'
import {Modal} from "react-bootstrap";
import {useSearchWikitags} from "../../hooks/useWikiTags";
import {useAuth} from "../../contexts/AuthContext";
import Tag from "../Tag/Tag";
import {useSuggestTags} from "../../hooks/useSuggest";
import {useToastContext} from "../../contexts/ToastContext";

type SuggestTagModalProps = {
    suggestTagModalShow: boolean,
    handleSuggestTagModalShow: () => void,
    entityType: number,
    entityId: number,
}


const SuggestTagModal = ({handleSuggestTagModalShow, suggestTagModalShow, entityId, entityType}: SuggestTagModalProps) => {

    const [newTag, setNewTag] = useState("");
    const [tagSearchTerm, setTagSearchTerm] = useState("");
    const [debouncedTagSearchTerm, setDebouncedTagSearchTerm] = useState("");
    const [isTagInputFocused, setIsTagInputFocused] = useState(false);

    const [wikiTags, setWikiTags] = useState([] as {id: string, name: string}[])

    const onTagSelect = (id: string, name: string) => {
        addTag(id, name);
    };

    const handleTagInputBlur = () => {
        setTimeout(() => {
            setIsTagInputFocused(false);
        }, 150);
    };

    const handleTagInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setNewTag(e.target.value);
        setTagSearchTerm(e.target.value);
    };

    const addTag = (id: string, name: string) => {
        const newTag = { id, name };
        if (!wikiTags.some((tag) => tag.name === name)) {
            setWikiTags([...wikiTags, newTag],);
        }
    };

    const removeTag = (indexToRemove: number) => {
        setWikiTags(wikiTags.filter(
                    (_, index) => index != indexToRemove
            ))
    };

    const { mutate: searchWikiTags, data: searchWikiTagsData } =
        useSearchWikitags({});

    const { axiosInstance } = useAuth();
    useEffect(() => {
        const timerId = setTimeout(() => {
            setDebouncedTagSearchTerm(tagSearchTerm);
        }, 500);

        return () => {
            clearTimeout(timerId);
        };
    }, [tagSearchTerm]);

    useEffect(() => {
        if (debouncedTagSearchTerm) {
            searchWikiTags({
                searchKey: debouncedTagSearchTerm,
                axiosInstance: axiosInstance,
            });
        }
    }, [debouncedTagSearchTerm]);


    const { toastState, setToastState } = useToastContext();
    const {mutate: suggestTags} = useSuggestTags({
        config: {
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Suggested Tags Successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Suggested Tags Successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Suggested Tags Successfully!"
                })), 6000);
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Tag Suggestion Failed. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Tag Suggestion Failed. Try again later!", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Tag Suggestion Failed. Try again later!"
                })), 6000);
            }
        }
    });

    const handleSubmit = (event: React.FormEvent) => {
        event.preventDefault()
        suggestTags({
            axiosInstance,
            data: {
                entityId,
                entityType,
                tags: wikiTags.map((tag) => tag.id)
            },
        })
        handleSuggestTagModalShow();

    }


    return (
        <Modal
            className="rounded-5"
            show={suggestTagModalShow}
            onHide={handleSuggestTagModalShow}
            size="lg"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0"
                closeButton
            ></Modal.Header>
            <Modal.Body className="bg-body-secondary d-flex justify-content-center">
                <div className="card-body  align-items-center d-flex flex-column bg-body-secondary w-75">
                    <div className="WA-theme-main fw-bold fs-5">Use the search bar to search for tags and click to add them</div>
                    <form onSubmit={handleSubmit} className="w-100">
                        <div className="mb-3">
                            <label htmlFor="wikiTags" className="form-label ">
                                Tags:
                            </label>
                            <div className="d-flex flex-wrap">
                                {wikiTags.map((tag, index) => (
                                    <div
                                        key={tag.id}
                                        className="m-2"
                                        style={{ cursor: "pointer" }}
                                        onClick={() => removeTag(index)}
                                    >
                                        <Tag className={""} label={tag.name} />
                                    </div>
                                ))}
                            </div>
                            <div className="w-100 text-center">
                                <input
                                    type="text"
                                    className="form-control"
                                    value={newTag}
                                    onChange={handleTagInputChange}
                                    onFocus={() => setIsTagInputFocused(true)}
                                    onBlur={handleTagInputBlur}
                                />
                                {isTagInputFocused &&
                                    searchWikiTagsData &&
                                    searchWikiTagsData.length > 0 && (
                                        <div className="dropdown-menu show">
                                            {searchWikiTagsData.map((tag: any) => (
                                                <div
                                                    key={tag.id}
                                                    className="dropdown-item"
                                                    onClick={() =>
                                                        onTagSelect(tag.id, tag.display.label.value)
                                                    }
                                                >
                                                    {tag.display.label.value} - {tag.description}
                                                </div>
                                            ))}
                                        </div>
                                    )}
                            </div>
                        </div>
                        <div className="d-flex justify-content-center">
                            <button type="submit" className="btn btn-primary WA-theme-bg-main WA-theme-light">
                                Suggest Tags
                            </button>
                        </div>
                    </form>
                </div>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>
    );
}

export default SuggestTagModal;
