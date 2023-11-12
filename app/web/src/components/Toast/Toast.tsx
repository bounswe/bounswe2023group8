import React from 'react';
import {useToastContext} from "../../contexts/ToastContext";
import {format} from "date-fns";

type ToastProps = {
    //First 3 are also toastState fields
    message: string,
    display: boolean,
    isError: boolean,

    className: string
}

const Toast = ({display, message, isError, className}: ToastProps) => {
    const { toastState, setToastState } = useToastContext();
    const bgColor = isError ? "bg-danger-subtle" : "bg-info-subtle"
    return (
            <div
                id="liveToast"
                className={`toast ${bgColor} ${display && "show"} ${className}`}
                role="alert" aria-live="assertive" aria-atomic="true">
                <div className="toast-header">
                        <strong className="me-auto">Web Info Aggregator</strong>
                        <small>{format(new Date(), "HH:mm")}</small>
                        <button type="button" className="btn-close" data-bs-dismiss="toast" aria-label="Close"
                                onClick={() => setToastState(toastState.filter(
                                    (toast) => toast.message != message
                                ))}/>
                </div>
                <div className="toast-body">
                    {message}
                </div>
            </div>
    )
}

export default Toast;
