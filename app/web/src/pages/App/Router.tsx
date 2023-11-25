import React from "react";
import { Navigate, Outlet, Route, Routes } from "react-router-dom";
import OpeningPage from "../OpeningPage";
import Topbar from "../../components/Layout/Topbar/Topbar";
import Sidebar from "../../components/Layout/Sidebar/Sidebar";
import ConfirmNewPassword from "../ConfirmNewPassword";
import ProfilePage from "../ProfilePage";
import { Col, Row } from "react-bootstrap";
import { useAuth } from "../../contexts/AuthContext";
import RegistrationConfirm from "../RegistrationConfirm";
import PostViewPage from "../PostViewPage";
import Toast from "../../components/Toast/Toast";
import { useToastContext } from "../../contexts/ToastContext";
import CreatePost from "../PostCreatePage";
import MapTestPage from "../MapTestPage";
import PostUpdatePage from "../PostUpdatePage";
import CreateInterestArea from "../InterestAreaCreatePage";
import InterestAreaViewPage from "../InterestAreaViewPage";

const Router = () => {
  const { isAuthenticated } = useAuth();
  const { toastState } = useToastContext();

  return (
    <Routes>
      {/* Pages that have neither topbar nor sidebar go here */}
      <Route
        path="/"
        element={
          <Col className="">
            <Row className="fixed-top" style={{ maxHeight: "60px" }}>
              <Topbar />
            </Row>
            <Row className="bottom-0 p-0 m-0 vw-100" style={{ top: 60 }}>
              <div
                className="toast-container top-0 end-0 p-3"
                style={{ top: 60 }}
              >
                {toastState.map((toast, index) => (
                  <Toast
                    className="mb-2"
                    key={index}
                    isError={toast.isError}
                    display={toast.display}
                    message={toast.message}
                  />
                ))}
              </div>
              <Outlet />
            </Row>
          </Col>
        }
      >
        {/* Pages that have only a topbar go here */}
        <Route path="/" element={<OpeningPage />} />
        <Route path="/reset-password" element={<ConfirmNewPassword />} />
        <Route
          path="/registration-confirm"
          element={<RegistrationConfirm />}
        />
        <Route
          element={
            <Row className="p-0 m-0 vw-100">
              <Col
                className="col-2 bg-body-secondary position-fixed bottom-0"
                style={{ top: 60 }}
              >
                <Sidebar />
              </Col>
              <Col
                className="col-10 position-relative"
                style={{ marginLeft: "17%", top: 60 }}
              >
                <Outlet />
              </Col>
            </Row>
          }
        >
          {/* Pages that have both a topbar and sidebar go here */}
          <Route path="/home" element={<OpeningPage />} />
          {isAuthenticated && <Route path="/profile" element={<ProfilePage />} />}
          <Route path="/create_post" element={<CreatePost />} />
          <Route path="/update_post/:postId" element={<PostUpdatePage />} />
          <Route
            path="/create_interest_area"
            element={<CreateInterestArea />}
          />
            <Route path="/interest-areas/:iaId" element={<InterestAreaViewPage />} />
            <Route path="/posts/:postId" element={<PostViewPage />} />

          <Route path="/map-test" element={<MapTestPage />} />
          <Route path="*" element={<Navigate to="/" />} />
        </Route>
      </Route>
    </Routes>
  );
};

export default Router;
