import React, { useEffect } from "react";
import { useAuth } from "../../contexts/AuthContext";
import { useNavigate } from "react-router-dom";

const RegistrationConfirm: React.FC = () => {
  const { confirmSignupToken } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    const searchParams = new URLSearchParams(window.location.search);
    const token = searchParams.get("token");
    if (token) {
      confirmSignupToken(token)
        .then(() => {
          navigate("/home");
        })
        .catch(() => {});
    } else {
      navigate("/login");
    }
  }, []);

  return <div>Registration Confirmation in Progress...</div>;
};

export default RegistrationConfirm;
