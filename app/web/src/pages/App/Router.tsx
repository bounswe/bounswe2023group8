import React from "react";
import {Outlet, Route, Routes} from "react-router-dom";
import OpeningPage from "../OpeningPage";
import Topbar from "../../components/Layout/Topbar/Topbar";
import Sidebar from "../../components/Layout/Sidebar/Sidebar";
import PageWithTopbarOnly from "../TemporaryRouterTestPages/PageWithTopbarOnly";
import PageWithNoWrapper from "../TemporaryRouterTestPages/PageWithNoWrapper";
import ConfirmNewPassword from "../ConfirmNewPassword";
import {Col, Row} from "react-bootstrap";

type RouterProps = {
    isUser: boolean;
}
const Router = (props: RouterProps) => (
    <Routes>
        {/*Pages that have neither topbar nor sidebar go here*/}

        <Route path="/no_bar" element={<PageWithNoWrapper/>}/>
        <Route path="/confirm-new-password" element={<ConfirmNewPassword/>}/>

        <Route
            path="/"
            element={
                <Col className="">
                    <Row className="fixed-top" style={{maxHeight: "87px"}}><Topbar isUser={props.isUser}/></Row>
                    <Row style={{marginTop: "87px"}}><Outlet/></Row>
                </Col>
            }
        >
            {/*Pages that have only a topbar go here*/}

            <Route path="/" element={<OpeningPage/>}/>
            <Route path="/topbar" element={<PageWithTopbarOnly/>}/>

            <Route
                element={
                    <Row className="p-0 m-0">
                        <Col className="col-2 bg-body-secondary position-fixed bottom-0"
                        style={{top: "87px"}}><Sidebar isUser={props.isUser}/></Col>
                        <Col className="col-10 overflow-y-auto" style={{marginLeft: "17%"}}><Outlet/></Col>
                    </Row>
                }
            >
                {/*Pages that have both a topbar and sidebar go here*/}

                <Route path="/home" element={<OpeningPage/>}/>
            </Route>
        </Route>
    </Routes>
);

export default Router;
