import React from 'react'
import Tag from "../Tag/Tag";
import {useAcceptTagSuggestion, useRejectTagSuggestion} from "../../hooks/useSuggest";
import {useToastContext} from "../../contexts/ToastContext";
import {useAuth} from "../../contexts/AuthContext";

export type SuggestionCardSmallProps = {
    id: number,
    label: string,
    requesterCount: number,
    wikiDataTagId: string,
    description: string,
    isValidTag: boolean,
    refetch: () => void,
}


const SuggestionCardSmall = ({description, id, label, requesterCount, refetch}: SuggestionCardSmallProps) => {


    const { toastState, setToastState } = useToastContext();

    const {mutate: accept} = useAcceptTagSuggestion({
        config: {
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Accepted successfully! Refresh to see the changes."
                });
                setToastState([
                    ...tempState,
                    {message: "Accepted successfully! Refresh to see the changes.", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Accepted successfully! Refresh to see the changes."
                })), 6000);
                refetch()
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Could not accept the tag. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Could not accept the tag. Try again later", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Could not accept the tag. Try again later"
                })), 6000);
            }
        }
    })
    const {mutate: reject} = useRejectTagSuggestion({
        config: {
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Rejected successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Rejected successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Rejected successfully!"
                })), 6000);
                refetch();
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Could not reject the tag. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Could not reject the tag. Try again later", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Could not reject the tag. Try again later"
                })), 6000);
            }
        }
    })

    const {axiosInstance} = useAuth();
    const handleAccept = () => {
        accept({
            axiosInstance,
            tagSuggestionId: id
        })
    }

    const handleReject = () => {
        reject({
            axiosInstance,
            tagSuggestionId: id
        })
    }

    return <div className="d-flex flex-row WA-theme-bg-light rounded-4 p-2 m-2 ">
        <div className="col-3 align-items-center d-flex flex-column me-2">
            <Tag className="w-100" label={label}></Tag>
            <span className="mx-1 WA-theme-main">{requesterCount > 1
                ? `By ${requesterCount} users`
                : `By ${requesterCount} user`}</span>
        </div>
        <div className="vr WA-theme-dark" style={{paddingLeft: '0.05em', paddingRight: '0.05em'}}></div>
        <span className="mx-1 col-7">{description}</span>
        <div className="vr WA-theme-dark" style={{paddingLeft: '0.05em', paddingRight: '0.05em'}}></div>
        <div className="d-flex flex-column w-100 px-1 justify-content-center">
            <button onClick={handleAccept} className="btn btn-sm WA-theme-bg-positive WA-theme-light mb-1 rounded-3">Accept</button>
            <button onClick={handleReject} className="btn btn-sm WA-theme-bg-negative WA-theme-light rounded-3">Reject</button>
        </div>
    </div>
}

export default SuggestionCardSmall
