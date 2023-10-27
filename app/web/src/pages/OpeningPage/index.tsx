import React from 'react';

const OpeningPage: React.FC = () => {
    return <>
        <div
            className="d-flex justify-content-center align-items-center vh-100"
            style={{
                backgroundImage: "url('/assets/opening_page.png')",
                backgroundSize: "cover",
                backgroundRepeat: "no-repeat",
                // width:"vh-",
                // height:"vh-100"
            }}
        >
        </div>
    </>
};

export default OpeningPage;
