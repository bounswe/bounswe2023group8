import React from "react";
import { Outlet, Route, Routes } from "react-router-dom";
import OpeningPage from "../OpeningPage";
import Topbar from "../../components/Layout/Topbar/Topbar";
import Sidebar from "../../components/Layout/Sidebar/Sidebar";
import PageWithTopbarOnly from "../TemporaryRouterTestPages/PageWithTopbarOnly";
import PageWithNoWrapper from "../TemporaryRouterTestPages/PageWithNoWrapper";
import ConfirmNewPassword from "../ConfirmNewPassword";
import ProfilePage from "../ProfilePage";
import { Col, Row } from "react-bootstrap";
import { useAuth } from "../../contexts/AuthContext";
import RegistrationConfirm from "../RegistrationConfirm";

const Router = () => {
  const { isAuthenticated } = useAuth();
  return (
    <Routes>
      {/*Pages that have neither topbar nor sidebar go here*/}

      <Route path="/no_bar" element={<PageWithNoWrapper />} />
      <Route path="/confirm-new-password" element={<ConfirmNewPassword />} />
      <Route path="/registration-confirm" element={<RegistrationConfirm />} />

        <Route
            path="/"
            element={
                <Col className="">
                    <Row className="fixed-top" style={{maxHeight: "60px"}}><Topbar isUser={isAuthenticated}/></Row>
                    <Row className="position-fixed bottom-0 p-0 m-0 vw-100"  style={{top: 60}}><Outlet/></Row>
                </Col>
            }
        >
            {/*Pages that have only a topbar go here*/}

        <Route path="/" element={<OpeningPage />} />
        <Route path="/topbar" element={<PageWithTopbarOnly />} />

            <Route
                element={
                    <Row className="p-0 m-0 vw-100">
                        <Col className="col-2 bg-body-secondary position-fixed bottom-0"
                        style={{top: "60px"}}><Sidebar isUser={isAuthenticated}/></Col>
                        <Col className="col-10" style={{marginLeft: "17%"}}><Outlet/></Col>
                    </Row>
                }
            >
                {/*Pages that have both a topbar and sidebar go here*/}

                <Route path="/home" element={<OpeningPage/>}/>
                <Route path="/profile" element={<ProfilePage/>}/>
            </Route>
        </Route>
      </Route>
    </Routes>
  );
};
export default Router;
