import React from "react";
import { useForm, SubmitHandler } from "react-hook-form";

type FormData = {
  email: string;
  username: string;
  birthday: Date;
  password: string;
  confirmPassword: string;
  termsOfService: boolean;
};

const RegisterModal: React.FC = () => {
  const {
    register,
    handleSubmit,
    formState: { errors },
    getValues,
  } = useForm<FormData>();

  const onSubmit: SubmitHandler<FormData> = (data) => {
    console.log(data);
    // handle registration logic here
  };

  return (
    <div className="card">
      <div className="card-body">
        <h2 className="card-title">Sign up</h2>
        <form onSubmit={handleSubmit(onSubmit)}>
          <div className="mb-3">
            <label className="form-label">E-mail:</label>
            <input
              className="form-control"
              {...register("email", { required: "This field is required" })}
            />
            {errors.email && (
              <span className="text-danger">{errors.email.message}</span>
            )}
          </div>

          <div className="mb-3">
            <label className="form-label">Username:</label>
            <input
              className="form-control"
              {...register("username", { required: "This field is required" })}
            />
            {errors.username && (
              <span className="text-danger">{errors.username.message}</span>
            )}
          </div>

          <div className="mb-3">
            <label className="form-label">Birthday:</label>
            <input
              type="date"
              className="form-control"
              {...register("birthday", { required: "This field is required" })}
            />
            {errors.birthday && (
              <span className="text-danger">{errors.birthday.message}</span>
            )}
          </div>

          <div className="mb-3">
            <label className="form-label">Password:</label>
            <input
              type="password"
              className="form-control"
              {...register("password", { required: "This field is required" })}
            />
            {errors.password && (
              <span className="text-danger">{errors.password.message}</span>
            )}
          </div>

          <div className="mb-3">
            <label className="form-label">Confirm Password:</label>
            <input
              type="password"
              className="form-control"
              {...register("confirmPassword", {
                required: "This field is required",
                validate: (value) =>
                  value === getValues("password") ||
                  "The passwords do not match", // <-- Adding validation
              })}
            />
            {errors.confirmPassword && (
              <span className="text-danger">
                {errors.confirmPassword.message}
              </span>
            )}
          </div>
          <div className="mb-3 form-check">
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

          <button type="submit" className="btn btn-primary">
            Sign up
          </button>
        </form>
      </div>
    </div>
  );
};

export default RegisterModal;
