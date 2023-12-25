import React, {useEffect} from 'react'
import {Modal} from "react-bootstrap";
import {useGetTagSuggestions} from "../../hooks/useSuggest";
import {useAuth} from "../../contexts/AuthContext";
import SuggestionCardSmall, {SuggestionCardSmallProps} from "./SuggestionCardSmall";

type ViewSuggestionsModalProps = {
    viewSuggestionsModalShow: boolean;
    handleViewSuggestionsModalShow: () => void;
    entityType: string;
    entityId: number;
}

const ViewSuggestionsModal = ({handleViewSuggestionsModalShow, viewSuggestionsModalShow,
                                  entityId, entityType}: ViewSuggestionsModalProps) => {

    const {axiosInstance} = useAuth();
    const {mutate: getTagSuggestions, isLoading, data: suggestions} = useGetTagSuggestions({});
    useEffect(() => {
        getTagSuggestions({
            axiosInstance,
            entityId,
            entityType,
        })
    }, [])

    const refetch = () => {
        getTagSuggestions({
            axiosInstance,
            entityId,
            entityType,
        })
    }

    return (
        <Modal
            className="rounded-5"
            show={viewSuggestionsModalShow}
            onHide={handleViewSuggestionsModalShow}
            size="lg"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0"
                closeButton
            ><div className=" text-center WA-theme-main fw-bold fs-4 w-100">Suggested Tags</div></Modal.Header>
            <Modal.Body className="bg-body-secondary d-flex justify-content-center">
                <div className="card-body  align-items-center d-flex flex-column bg-body-secondary w-75">
                    {isLoading
                        ? <div className="fs-5 fw-bold WA-theme-main">Loading...</div>
                        : <div className="w-100">{ suggestions?.length > 0
                            ? <div>{suggestions.map(({
                                                         description,
                                                         id,
                                                         isValidTag,
                                                         label,
                                                         requesterCount,
                                                         wikiDataTagId
                                                     }: SuggestionCardSmallProps, index: number) => {
                                return <SuggestionCardSmall id={id}
                                                            label={label}
                                                            requesterCount={requesterCount}
                                                            wikiDataTagId={wikiDataTagId}
                                                            description={description}
                                                            isValidTag={isValidTag}
                                                            refetch={refetch}
                                                            key={index} />
                            })}</div>
                            : <div className="w-100 text-center"> No Suggestions </div>
                        }
                        </div>
                    }
                </div>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>
    );
}

export default ViewSuggestionsModal
