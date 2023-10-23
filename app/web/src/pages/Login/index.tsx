import React, { useState } from "react";
import LoginModal from "../../components/Login/LoginModal";
const Register: React.FC = () => {
  const [showLoginModal, setShowLoginModal] = useState(true);
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
        <LoginModal
          showModal={showLoginModal}
          handleClose={() => setShowLoginModal(!showLoginModal)}
        />
      </div>
    </>
  );
};

export default Register;
