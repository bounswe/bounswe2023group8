import React from "react";
import {Modal} from "react-bootstrap";
import {useForm, SubmitHandler} from "react-hook-form";

type FormData = {
    password: string;
    confirmPassword: string;
};

type ConfirmNewPasswordModalProps = {
    showModal: boolean;
    handleClose: () => void;
};

const ConfirmNewPasswordModal = (props: ConfirmNewPasswordModalProps) => {
    const {
        register,
        handleSubmit,
        formState: {errors},
        getValues,
    } = useForm<FormData>();
    const {showModal, handleClose} = props;
    const onSubmit: SubmitHandler<FormData> = (data) => {
        console.log(data);
        // handle registration logic here
    };

    return (
        <Modal
            className="rounded-5"
            show={showModal}
            onHide={handleClose}
            size="lg"
            centered
        >
            <Modal.Header
                className="bg-body-secondary border-0"
                closeButton
            ></Modal.Header>
            <Modal.Body className="bg-body-secondary ">
                <div className="card-body align-items-center d-flex flex-column bg-body-secondary">
                    <form onSubmit={handleSubmit(onSubmit)}>
                        <div className="m-3 d-flex flex-column">
                            <div className="d-flex justify-content-center align-items-center">
                                <img
                                    src="/assets/logo.png"
                                    alt="Logo"
                                    style={{width: "100px"}}
                                />
                            </div>

                            <h2
                                className="card-title text-center mt-3 fw-bolder"
                                style={{color: "#324ca8"}}
                            >
                                Create New Password
                            </h2>
                            <div className="mt-2">
                                <input
                                    type="password"
                                    className="form-control shadow rounded-5"
                                    {...register("password", {
                                        required: "This field is required",
                                    })}
                                    placeholder="Password"
                                />
                                {errors.password && (
                                    <span className="text-danger">{errors.password.message}</span>
                                )}
                            </div>

                            <div className="mt-2">
                                <input
                                    type="password"
                                    className="form-control shadow rounded-5"
                                    {...register("confirmPassword", {
                                        required: "This field is required",
                                        validate: (value) =>
                                            value === getValues("password") ||
                                            "The passwords do not match", // <-- Adding validation
                                    })}
                                    placeholder="Confirm password"
                                />
                                {errors.confirmPassword && (
                                    <span className="text-danger">
                    {errors.confirmPassword.message}
                  </span>
                                )}
                            </div>

                            <div className="mt-3 align-self-lg-center">
                                <button
                                    type="submit"
                                    className="btn btn-primary rounded-5 col-12 fw-bolder"
                                >
                                    Submit New Password
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </Modal.Body>
            <Modal.Footer className="bg-body-secondary border-0 rounded-5"></Modal.Footer>
        </Modal>
    );
};

export default ConfirmNewPasswordModal;
