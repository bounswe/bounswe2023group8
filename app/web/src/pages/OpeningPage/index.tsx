import React from 'react';
import {Button} from "react-bootstrap";
import {useNavigate} from "react-router-dom";

const OpeningPage: React.FC = () => {
    const navigate = useNavigate();
    return <>
        <div
            className="container vh-100 p-0 m-0"
            style={{
                backgroundImage: "url('/assets/opening_page.png')",
                backgroundSize: "contain",
                backgroundPosition: "center",
                display: "flex",
            }}
        >
            <div style={{flex: 1, justifyContent: "center", alignItems: "center", flexDirection: "column", display: "flex"}}>
                <Button style={{marginBottom: 80}} onClick={() =>{ navigate("/home")}}>
                    <h3>Explore!</h3>
                </Button>
            </div>
        </div>
    </>
};

export default OpeningPage;
