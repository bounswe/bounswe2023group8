import React from 'react';
import Navbar from "react-bootstrap/Navbar";
import Nav from "react-bootstrap/Nav";

type SidebarProps = {
    isUser: boolean;
}

const Sidebar = (props: SidebarProps) => {
    return <Navbar className="d-flex flex-column h-100">
        {props.isUser
            ? <Nav className="container flex-column h-100 align-items-start px-3">
                <Nav.Link href="#home">
                    <span className="fs-5 bi bi-house-door-fill"> Home</span>
                </Nav.Link>
                <Nav.Link href="#profile">
                    <span className="fs-5 bi bi-person-circle"> Profile</span>
                </Nav.Link>
                <Nav.Link href="#explore">
                    <span className="fs-5 bi bi-globe"> Explore</span>
                </Nav.Link>
                <div className="mt-auto">
                    <Nav.Link href="#settings">
                        <span className="fs-5 bi bi-gear-fill "> Settings</span>
                    </Nav.Link>
                </div>
            </Nav>
            : <Nav className="container flex-column h-100 align-items-start px-3">
                <Nav.Link href="#explore">
                    <span className="fs-5 bi bi-globe"> Explore</span>
                </Nav.Link>
            </Nav>
        }
    </Navbar>
};

export default Sidebar;
