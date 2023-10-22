import React, { useState } from "react";
import RegisterModal from "../../components/Register/RegisterModal";
const Register: React.FC = () => {
  const [showRegisterModal, setShowRegisterModal] = useState(true);
  return (
    <>
      <div
        className="d-flex justify-content-center align-items-center vh-100"
        style={{
          backgroundImage: "url('/assets/opening_page.png')",
          backgroundSize: "100% 100%",
          backgroundRepeat: "no-repeat",
        }}
      >
        <RegisterModal
          showModal={showRegisterModal}
          handleClose={() => setShowRegisterModal(!showRegisterModal)}
        />
      </div>
    </>
  );
};

export default Register;
