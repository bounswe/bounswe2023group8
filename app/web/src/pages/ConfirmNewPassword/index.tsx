import React, { useState } from "react";
import ConfirmNewPasswordModal from "../../components/ConfirmNewPassword/ConfirmNewPassword";

const ConfirmNewPassword: React.FC = () => {
  const [showConfirmNewPasswordModal, setShowConfirmNewPasswordModal] = useState(true);
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
        <ConfirmNewPasswordModal
          showModal={showConfirmNewPasswordModal}
          handleClose={() => setShowConfirmNewPasswordModal(!showConfirmNewPasswordModal)}
        />
      </div>
    </>
  );
};

export default ConfirmNewPassword;
