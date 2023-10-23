import React, { useState } from "react";
import ForgotPasswordModal from "../../components/ForgotPassword/ForgotPasswordModal";
const ForgotPassword: React.FC = () => {
  const [showForgotPasswordModal, setShowForgotPasswordModal] = useState(true);
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
        <ForgotPasswordModal
          showModal={showForgotPasswordModal}
          handleClose={() => setShowForgotPasswordModal(!showForgotPasswordModal)}
        />
      </div>
    </>
  );
};

export default ForgotPassword;
