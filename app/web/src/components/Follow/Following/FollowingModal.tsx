import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowingCard from './FollowingCard'; // Import your predefined FollowerCard component
import mockUsers from '../../../mockData/milestone1/451_users.json';

type FollowerModalProps = {
    show: boolean;
    //onClose: () => void;
    setShow: (value: boolean) => void;
};

const FollowingModal: React.FC<FollowerModalProps> = ({ show}) => {
    const followersData = mockUsers.slice(0, 4);

    return (
        <Modal
            show={show}
            //onHide={onClose}
            centered
            className="follower-modal"
        >
            <Modal.Header closeButton>
                <Modal.Title>Followers</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Row>
                    <Col md={12} className="text-center mb-3">
                        <Button
                            className="close-button"
                            variant="link"
                            //onClick={onClose}
                        >
                        </Button>
                    </Col>
                </Row>
                <Row className="follower-list">
                    {followersData.map((follower) => (
                        <Col key={follower.id} md={12} className="mb-3">
                            <FollowingCard user={follower} />
                        </Col>
                    ))}
                </Row>
            </Modal.Body>
        </Modal>
    );
};

export default FollowingModal;
