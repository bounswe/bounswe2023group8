import React from "react";
import RegisterModal from "../../components/Register/RegisterModal";

const Register: React.FC = () => {
  return (
    <>
      <div className="d-flex justify-content-center align-items-center vh-100">
        <RegisterModal />
      </div>
    </>
  );
};

export default Register;
