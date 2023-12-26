import React from "react";
import { Modal } from "react-bootstrap";
import { useForm, SubmitHandler } from "react-hook-form";
import SpanWithOnClick from "../shared/SpanWithOnClick/SpanWithOnClick";
import { useAuth } from "../../contexts/AuthContext";

export type FormData = {
  email: string;
  username: string;
  name: string;
  birthday: Date;
  password: string;
  confirmPassword: string;
  termsOfService: boolean;
};

type RegisterModalProps = {
  showRegisterModal: boolean;
  setShowRegisterModal: () => void;
  setShowLoginModal: () => void;
};

const RegisterModal = (props: RegisterModalProps) => {
  const { signup } = useAuth();
  const {
    register,
    handleSubmit,
    formState: { errors },
    getValues,
  } = useForm<FormData>();
  const { showRegisterModal, setShowRegisterModal, setShowLoginModal } = props;
  const onSubmit: SubmitHandler<FormData> = async (data) => {
    try {
      await signup(data);
      setShowRegisterModal();
      // TODO: show email verification modal
    } catch (error) {
      console.error("Signup failed:", error);
    }
  };

  return (
    <Modal
      className="rounded-5"
      show={showRegisterModal}
      onHide={setShowRegisterModal}
      size="lg"
      centered
    >
      <Modal.Header
        className="bg-body-secondary border-0"
        closeButton
      ></Modal.Header>
      <Modal.Body className="bg-body-secondary">
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
                Sign up
              </h2>

              <div className="mt-3">
                <input
                  className="form-control shadow rounded-5"
                  {...register("email", { required: "This field is required" })}
                  placeholder="E-mail"
                />
                {errors.email && (
                  <span className="text-danger">{errors.email.message}</span>
                )}
              </div>

              <div className="mt-2">
                <input
                  className="form-control shadow rounded-5"
                  {...register("username", {
                    required: "This field is required",
                  })}
                  placeholder="Username"
                />
                {errors.username && (
                  <span className="text-danger">{errors.username.message}</span>
                )}
              </div>
              <div className="mt-2">
                <input
                  className="form-control shadow rounded-5"
                  {...register("name", {
                    required: "This field is required",
                  })}
                  placeholder="Name"
                />
                {errors.name && (
                  <span className="text-danger">{errors.name.message}</span>
                )}
              </div>

              <div className="mt-2">
                <input
                  type="date"
                  className="form-control shadow rounded-5"
                  {...register("birthday", {
                    required: "This field is required",
                  })}
                />
                {errors.birthday && (
                  <span className="text-danger">{errors.birthday.message}</span>
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

              <div className="mt-2 form-check">
                <input
                  type="checkbox"
                  className="form-check-input"
                  {...register("termsOfService", {
                    required: "You must accept the terms of service",
                  })}
                />
                <label className="form-check-label">
                  I accept the Terms of Service
                </label>
                {errors.termsOfService && (
                  <span className="text-danger d-block">
                    {errors.termsOfService.message}
                  </span>
                )}
              </div>

              <div className="mt-3 ">
                Already have an account?
                <SpanWithOnClick
                  className="text-primary fw-bolder"
                  text={" Log in"}
                  onClick={() => {
                    setShowRegisterModal();
                    setShowLoginModal();
                  }}
                />
              </div>
              <div className="mt-2">
                <button
                  type="submit"
                  className="btn btn-primary rounded-5 col-12 fw-bolder"
                >
                  Sign up
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
export default RegisterModal;
