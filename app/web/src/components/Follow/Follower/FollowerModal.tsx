import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowerCard from './FollowerCard';
import mockUsers from '../../../mockData/milestone1/451_users.json';

type FollowerModalProps = {
    show: boolean;
    //onClose: () => void;  // Corrected prop name
    setShow: (value: boolean) => void;
};

const FollowerModal: React.FC<FollowerModalProps> = ({ show, setShow }) => {
    const followersData = mockUsers.slice(0, 4);

    return (
        <Modal show={show}  centered className="follower-modal">
            <Modal.Header closeButton>
                <Modal.Title className="text-center font-weight-bold">Followers</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Row className="follower-list">
                    {followersData.map((follower) => (
                        <Col key={follower.id} md={12} className="mb-3">
                            <FollowerCard user={follower} />
                        </Col>
                    ))}
                </Row>
                <Row className="justify-content-center">
                    <Col md={2} className="text-center">
                        <Button
                            className="close-button"
                            variant="link"
                            onClick={() => setShow(false)}
                        >
                        </Button>
                    </Col>
                </Row>
            </Modal.Body>
        </Modal>
    );
};

export default FollowerModal;
