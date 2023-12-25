import React, { useState } from "react";

import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";
import NavDropdown from "react-bootstrap/NavDropdown";
import { Button } from "react-bootstrap";
import RegisterModal from "../../Register/RegisterModal";
import LoginModal from "../../Login/LoginModal";
import ForgotPasswordModal from "../../ForgotPassword/ForgotPasswordModal";
import { useAuth } from "../../../contexts/AuthContext";
import { useNavigate } from "react-router-dom";
import SpanWithOnClick from "../../shared/SpanWithOnClick/SpanWithOnClick";

const mockNotifications = [
  {
    href: "notification1",
    title: 'Your Bunch "All About Rice" is trending!',
  },
  { href: "notification2", title: "You gained a badge: Food Enthusiast!" },
];

const Topbar = () => {
  const [showRegisterModal, setShowRegisterModal] = useState(false);
  const [showLoginModal, setShowLoginModal] = useState(false);
  const [showForgotPasswordModal, setShowForgotPasswordModal] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");

  const handleKeyPress = (event: any) => {
    if (event.key === 'Enter') {
      event.preventDefault();
      navigate(`search_results/${searchTerm}`);
    }
  };

  const navigate = useNavigate();
  const handleRegisterShow = () => {
    setShowRegisterModal(!showRegisterModal);
  };
  const { logout, isAuthenticated, userData } = useAuth();

  const handleLoginShow = () => {
    setShowLoginModal(!showLoginModal);
  };

  const handleForgotPasswordShow = () => {
    setShowForgotPasswordModal(!showForgotPasswordModal);
  };

  const handleLogOut = () => {
    logout();
    navigate("/");
  };

  return (
    <div>
      <Navbar
        className="bg-body border-bottom border-dark-subtle
            navbar-expand-md navbar-expand-lg navbar-expand-sm"
        style={{ maxHeight: "60px" }}
      >
        <Container className="m-0 min-vw-100">
          <Navbar.Brand href="/">
            <img
              alt=""
              src="/assets/logo.png"
              className="d-inline-block align-top"
              width="38px"
              height="43px"
            />{" "}
            {/* <span className="fs-3">Web Info Aggregator</span> */}
          </Navbar.Brand>
          {/* <Navbar.Toggle aria-controls="basic-navbar-nav" /> */}
          <Navbar.Collapse id="basic-navbar-nav" style={{marginLeft: "200px"}}>
            <div className="d-flex me-auto">
              <input
                type="search"
                placeholder="Search"
                className="me-2"
                aria-label="Search"
                value={searchTerm}
                style={{ width: '500px', borderRadius: '25px', borderWidth: '2px', borderColor: '#88898a', padding: '5px 10px', outline: 'none'}}
                onChange={(e) => setSearchTerm(e.target.value)}
                onKeyDown={handleKeyPress}
              />
              {/* <Button
                variant="outline-success"
                onClick={(event: any) => {
                  event.preventDefault();
                  navigate(`search_results/${searchTerm}`);
                }}
              >
                Search
              </Button> */}
            </div>
            {isAuthenticated ? (
              <Nav className="container justify-content-end m-3 ">
                <NavDropdown
                  title={<span className="fs-5 bi bi-bell"></span>}
                  id="collapsible-nav-dropdown"
                  drop="start"
                >
                  {mockNotifications.map((notification) => (
                    <NavDropdown.Item
                      key={notification.title}
                      href={notification.href}
                    >
                      {notification.title}
                    </NavDropdown.Item>
                  ))}
                </NavDropdown>
                <NavDropdown
                  title={
                    <span>
                      <span className="fs-5 bi bi-person"></span>
                      <span>{userData.name}</span>
                    </span>
                  }
                  id="collapsible-nav-dropdown"
                  drop="start"
                >
                  <NavDropdown.Item onClick={handleLogOut}>
                    <SpanWithOnClick
                      className="text-primary fw-bolder"
                      onClick={() => {}}
                      text={"Log Out"}
                    />
                  </NavDropdown.Item>
                </NavDropdown>
              </Nav>
            ) : (
              <Nav className="container justify-content-end m-3 ">
                <Button
                  className="btn btn-primary rounded-5 fw-bolder me-3"
                  onClick={handleLoginShow}
                >
                  Login
                </Button>
                <Button
                  className="text-primary btn bg-dark-subtle rounded-5 fw-bolder me-3 btn-outline-light"
                  onClick={handleRegisterShow}
                >
                  Sign up
                </Button>
              </Nav>
            )}
          </Navbar.Collapse>
        </Container>
      </Navbar>
      <RegisterModal
        showRegisterModal={showRegisterModal}
        setShowRegisterModal={handleRegisterShow}
        setShowLoginModal={handleLoginShow}
      />
      <LoginModal
        showLoginModal={showLoginModal}
        setShowLoginModal={handleLoginShow}
        setShowRegisterModal={handleRegisterShow}
        setShowForgotPasswordModal={handleForgotPasswordShow}
      />
      <ForgotPasswordModal
        showModal={showForgotPasswordModal}
        setShowForgotPasswordModal={handleForgotPasswordShow}
      />
    </div>
  );
};

export default Topbar;
