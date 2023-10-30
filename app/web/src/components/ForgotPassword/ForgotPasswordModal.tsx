import React from "react";
import { Modal } from "react-bootstrap";
import { useForm, SubmitHandler } from "react-hook-form";
import axios from "axios";
import { useToastContext} from "../../contexts/ToastContext";

type FormData = {
  email: string;
};

type ForgotPasswordModalProps = {
  showModal: boolean;
  setShowForgotPasswordModal: () => void;
};

const axiosInstance = axios.create({
  baseURL: `${process.env.REACT_APP_BACKEND_API_URL}`,
  headers: {
    "Content-Type": "application/json",
  },
});

const requestPasswordReset = async (data: FormData) => {
  const params = new URLSearchParams({
    email: data.email,
  }).toString();

  return await axiosInstance.get(`/auth/forgot-password?${params}`);
}

const ForgotPasswordModal = (props: ForgotPasswordModalProps) => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormData>();
  const { showModal, setShowForgotPasswordModal } = props;
  const { toastState, setToastState } = useToastContext();

  const onSubmit: SubmitHandler<FormData> = async (data) => {
    try {
      const response = await requestPasswordReset(data);
      if (response?.status === 200){
        const tempState = toastState.filter((toast) => {
          return toast.message != "Verification Email sent!"
        });
        setToastState([
          ...tempState,
          {message: "Verification Email sent!", display: true, isError: false}
        ]);
        setTimeout(() => setToastState(toastState.filter((toast) => {
          return toast.message != "Verification Email sent!"
        })), 6000);
      }
      setShowForgotPasswordModal();
    } catch (error) {
      console.error("Password reset failed:", error);
    }

  };

  return (
    <Modal
      className="rounded-5"
      show={showModal}
      onHide={setShowForgotPasswordModal}
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
                  style={{ width: "100px" }}
                />
              </div>

              <h2
                className="card-title text-center mt-3 fw-bolder"
                style={{ color: "#324ca8" }}
              >
                Forgot Password
              </h2>
              <div className="mt-3 col-lg-9 align-self-lg-center">
                <input
                  className="form-control shadow rounded-5"
                  {...register("email", { required: "This field is required" })}
                  placeholder="E-mail"
                />
                {errors.email && (
                  <span className="text-danger">{errors.email.message}</span>
                )}
              </div>

              <div className="mt-3 col-lg-9 text-center align-self-lg-center">
                We’ll send a verification code to this email if it matches an
                existing account.
              </div>

              <div className="mt-3 col-lg-6 align-self-lg-center">
                <button
                  type="submit"
                  className="btn btn-primary rounded-5 col-12 fw-bolder"
                >
                  Reset Password
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

export default ForgotPasswordModal;
