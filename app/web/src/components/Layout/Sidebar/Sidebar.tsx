import React from "react";
import Navbar from "react-bootstrap/Navbar";
import Nav from "react-bootstrap/Nav";
import { useAuth } from "../../../contexts/AuthContext";

const Sidebar = () => {
  const { isAuthenticated, userData } = useAuth();
  return (
    <Navbar className="d-flex flex-column h-100">
      {isAuthenticated ? (
        <Nav className="container flex-column h-100 align-items-start px-1">
          <Nav.Link href="/home">
            <span className="fs-5 bi bi-house-door-fill"> Home</span>
          </Nav.Link>
          <Nav.Link href={`/profile/${userData.id}`}>
            <span className="fs-5 bi bi-person-circle"> Profile</span>
          </Nav.Link>
          <Nav.Link href={`/create_interest_area`}>
            <svg
              width="26"
              height="30"
              viewBox="0 0 26 30"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M7.85714 3H1V29H25V3H18.1429"
                stroke="#434343"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              <path
                d="M18 1H8V3V5H18V3V1Z"
                stroke="#434343"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              <path
                d="M8 17H18"
                stroke="#434343"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              <path
                d="M13 12V22"
                stroke="#434343"
                strokeWidth="1.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
            <span className="fs-5"> Create Bunch</span>
          </Nav.Link>
          <div className="mt-auto">
            <Nav.Link href="#settings">
              <span className="fs-5 bi bi-gear-fill "> Settings</span>
            </Nav.Link>
          </div>
        </Nav>
      ) : (
        <Nav className="container flex-column h-100 align-items-start px-3">
          <Nav.Link href="#explore">
            <span className="fs-5 bi bi-globe"> Explore</span>
          </Nav.Link>
        </Nav>
      )}
    </Navbar>
  );
};

export default Sidebar;
