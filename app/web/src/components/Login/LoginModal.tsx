import React from "react";

import { Modal } from "react-bootstrap";
import { useForm, SubmitHandler } from "react-hook-form";
import SpanWithOnClick from "../shared/SpanWithOnClick/SpanWithOnClick";
import { useAuth } from "../../contexts/AuthContext";
import { useNavigate } from "react-router-dom";

export type LoginFormData = {
  emailOrUsername: string;
  password: string;
};

type LoginModalProps = {
  showLoginModal: boolean;
  setShowLoginModal: () => void;
  setShowRegisterModal: () => void;
  setShowForgotPasswordModal: () => void;
};

const LoginModal = (props: LoginModalProps) => {
  const navigate = useNavigate();
  const { login } = useAuth();
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginFormData>();
  const {
    showLoginModal,
    setShowLoginModal,
    setShowRegisterModal,
    setShowForgotPasswordModal,
  } = props;
  const onSubmit: SubmitHandler<LoginFormData> = async (data) => {
    try {
      await login(data);
      setShowLoginModal();
      navigate("/home");
    } catch (error) {
      console.error("Signup failed:", error);
    }
  };

  return (
    <Modal
      className="rounded-5"
      show={showLoginModal}
      onHide={setShowLoginModal}
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
            <div className="m-3">
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
                Log in
              </h2>
              <div className="mt-3">
                <input
                  className="form-control shadow rounded-5"
                  {...register("emailOrUsername", {
                    required: "This field is required",
                  })}
                  placeholder="E-mail or Username"
                />
                {errors.emailOrUsername && (
                  <span className="text-danger">
                    {errors.emailOrUsername.message}
                  </span>
                )}
              </div>

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
              <div
                className="mt-2 d-flex flex-column"
                style={{ alignItems: "end" }}
              >
                <SpanWithOnClick
                  className={"text-primary fw-bolder"}
                  text={"Forgot your password?"}
                  onClick={() => {
                    setShowLoginModal();
                    setShowForgotPasswordModal();
                  }}
                />
              </div>

              <div className="mt-3">
                Don&apos;t have an account?{" "}
                <SpanWithOnClick
                  className={"text-primary fw-bolder"}
                  text={"Sign up"}
                  onClick={() => {
                    setShowLoginModal();
                    setShowRegisterModal();
                  }}
                />
              </div>
              <div className="mt-2">
                <button
                  type="submit"
                  className="btn btn-primary rounded-5 col-12 fw-bolder"
                >
                  Log in
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

export default LoginModal;
