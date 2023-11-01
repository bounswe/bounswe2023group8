import React from "react";
import {Navigate, Outlet, Route, Routes} from "react-router-dom";
import OpeningPage from "../OpeningPage";
import Topbar from "../../components/Layout/Topbar/Topbar";
import Sidebar from "../../components/Layout/Sidebar/Sidebar";
import ConfirmNewPassword from "../ConfirmNewPassword";
import ProfilePage from "../ProfilePage";
import {Col, Row} from "react-bootstrap";
import {useAuth} from "../../contexts/AuthContext";
import RegistrationConfirm from "../RegistrationConfirm";
import FollowerPage from "../Follow/Follower";
import FollowingPage from "../Follow/Following";
import Toast from "../../components/Toast/Toast";
import {useToastContext} from "../../contexts/ToastContext";

const Router = () => {
    const {isAuthenticated} = useAuth();
    const {toastState} = useToastContext();

    return (
        <Routes>
            {/*Pages that have neither topbar nor sidebar go here*/}


            <Route
                path="/"
                element={
                    <Col className="">
                        <Row className="fixed-top" style={{maxHeight: "60px"}}><Topbar/></Row>
                        <Row className="position-fixed bottom-0 p-0 m-0 vw-100" style={{top: 60}}>
                            <div className="toast-container top-0 end-0 p-3" style={{top: 60}}>
                                {toastState.map((toast, index) => (
                                    <Toast className="mb-2" key={index} isError={toast.isError} display={toast.display}
                                           message={toast.message}/>
                                ))}
                            </div>
                            <Outlet/>
                        </Row>
                    </Col>
                }
            >
                {/*Pages that have only a topbar go here*/}
                <Route path="/" element={<OpeningPage/>}/>
                <Route path="/reset-password" element={<ConfirmNewPassword/>}/>
                <Route path="/registration-confirm" element={<RegistrationConfirm/>}/>
              
                <Route path="/follower-page" element={<FollowerPage/>} />
                <Route path="/following-page" element={<FollowingPage/>} />

                <Route
                    element={
                        <Row className="p-0 m-0 vw-100">
                            <Col className="col-2 bg-body-secondary position-fixed bottom-0"
                                 style={{top: 60}}><Sidebar/></Col>
                            <Col className="col-10" style={{marginLeft: "17%"}}><Outlet/></Col>
                        </Row>
                    }
                >
                    {/*Pages that have both a topbar and sidebar go here*/}
                    <Route path="/home" element={<OpeningPage/>}/>
                    {isAuthenticated && <Route path="/profile" element={<ProfilePage/>}/>}
                    <Route path="*" element={<Navigate to="/"/>}/>
                </Route>
            </Route>
        </Routes>
    );
};
export default Router;
