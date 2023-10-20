import React from 'react';
import {
    Outlet,
    Route, Routes,
} from 'react-router-dom';
import OpeningPage from "../OpeningPage";
import Topbar from "../../components/Layout/Topbar/Topbar";
import Sidebar from "../../components/Layout/Sidebar/Sidebar";
import PageWithTopbarOnly from "../TemporaryRouterTestPages/PageWithTopbarOnly";
import PageWithTopbarAndSidebar from "../TemporaryRouterTestPages/PageWithTopbarAndSidebar";
import PageWithNoWrapper from "../TemporaryRouterTestPages/PageWithNoWrapper";

const Router = () => (
    <Routes>
        {/*Pages that have neither topbar nor sidebar go here*/}

        <Route path="/no_bar" element={<PageWithNoWrapper />} />

        <Route path="/" element={
            <div>
                <Topbar/>
                <Outlet/>
            </div>}>
            {/*Pages that have only a topbar go here*/}

            <Route path="/" element={<OpeningPage/>}/>
            <Route path="/topbar" element={<PageWithTopbarOnly/>}/>

            <Route element={
                <div>
                    <Sidebar/>
                    <Outlet/>
                </div>}>
                {/*Pages that have both a topbar and sidebar go here*/}

                <Route path="/both_bars" element={<PageWithTopbarAndSidebar/>}/>
            </Route>
        </Route>
    </Routes>
);

export default Router;