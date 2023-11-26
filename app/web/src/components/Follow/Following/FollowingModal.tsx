import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowingCard from './FollowingCard';
import mockUsers from '../../../mockData/milestone1/451_users.json';

type FollowingModalProps = {
    show: boolean;
    setShow: (value: boolean) => void;
};

const FollowingModal: React.FC<FollowingModalProps> = ({ show, setShow }) => {
    const shuffledUsers = mockUsers.sort(() => 0.5 - Math.random());
    const FollowingsData = shuffledUsers.slice(0, 7);

    return (
        <Modal show={show} centered className="Following-modal">
            <Modal.Header closeButton>
                <Modal.Title className="text-center font-weight-bold">Following</Modal.Title>
            </Modal.Header>
            <Modal.Body style={{ maxHeight: '400px', overflowY: 'auto' }}>
                <Row className="Following-list">
                    {FollowingsData.map((Following) => (
                        <Col key={Following.id} md={12} className="mb-3">
                            <FollowingCard user={Following} />
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

export default FollowingModal;
