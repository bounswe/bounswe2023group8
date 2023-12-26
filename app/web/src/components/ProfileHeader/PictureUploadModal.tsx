import React, {useRef, useState} from 'react'
import {Modal} from "react-bootstrap";
import Tag from "../Tag/Tag";
import {useDeleteProfilePicture, useUploadProfilePicture} from "../../hooks/useUser";
import {useAuth} from "../../contexts/AuthContext";
import {useToastContext} from "../../contexts/ToastContext";
import axios from "axios";

export type PictureUploadModalProps = {
    show: boolean;
    handleShow: () => void;
    getProfile: any;
}
const PictureUploadModal = ({handleShow, show, getProfile}: PictureUploadModalProps) => {


    const { token } = useAuth()
    const inputRef = useRef<HTMLInputElement>(null);
    const { toastState, setToastState } = useToastContext();
    const {axiosInstance} = useAuth()
    const uploadAxiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_BACKEND_API_URL}`,
        headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": `Bearer ${token}`,
            "Accept": "application/json"
        },
    });
    const {mutate: uploadProfilePicture} = useUploadProfilePicture({
        config:{
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Picture Uploaded Successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Picture Uploaded Successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Picture Uploaded Successfully!"
                })), 6000);
                handleShow()
                getProfile()

            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Picture Upload Failed. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Picture Upload Failed. Try again later!", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Picture Upload Failed. Try again later!"
                })), 6000);
            }
        }
    })
    const {mutate: deleteProfilePicture} = useDeleteProfilePicture({
        config:{
            onSuccess: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Picture Deleted Successfully!"
                });
                setToastState([
                    ...tempState,
                    {message: "Picture Deleted Successfully!", display: true, isError: false}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Picture Deleted Successfully!"
                })), 6000);
                handleShow()
                getProfile()
            },
            onError: () => {
                const tempState = toastState.filter((toast) => {
                    return toast.message != "Picture Delete Failed. Try again later!"
                });
                setToastState([
                    ...tempState,
                    {message: "Picture Delete Failed. Try again later!", display: true, isError: true}
                ]);
                setTimeout(() => setToastState(toastState.filter((toast) => {
                    return toast.message != "Picture Delete Failed. Try again later!"
                })), 6000);
            }
        }
    })


    const handleSubmit = (): void => {

        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-expect-error
        const file = inputRef.current?.files[0]; // Get the file from the file input
        if (!file) {
            alert("No file selected!");
            return;
        }

        const formData = new FormData(); // Create a FormData object
        formData.append('image', file, file.name); // Append the file to the FormData object

        uploadProfilePicture({
            axiosInstance: uploadAxiosInstance,
            data: formData,
        })
    }

    const handleDelete = () => {
        deleteProfilePicture({
            axiosInstance
        })
    }

    return (
        <Modal
            className="rounded-5"
            show={show}
            onHide={handleShow}
            size="lg"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0"
                closeButton
            ></Modal.Header>
            <Modal.Body className="bg-body-secondary d-flex justify-content-center">
                <div className="card-body  align-items-center d-flex flex-column bg-body-secondary w-75">
                    <div className="WA-theme-main fw-bold fs-5">Upload a profile picture of your choice</div>
                    <form onSubmit={handleSubmit} className="w-100 ">
                        <div className="mb-3 ">
                            <div className="w-100 text-center">
                                <input
                                    ref={inputRef}
                                    type="file"
                                    className="form-control"
                                />
                            </div>
                        </div>
                    </form>
                    <div className="d-flex justify-content-between w-100">
                        <button className="btn btn-primary WA-theme-bg-negative WA-theme-light mx-2"
                                onClick={handleDelete}>Delete Profile Picture
                        </button>
                        <button className="btn btn-primary WA-theme-bg-main WA-theme-light"
                                onClick={() => handleSubmit()}>Submit
                        </button>
                    </div>
                </div>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>
    )
}

export default PictureUploadModal
