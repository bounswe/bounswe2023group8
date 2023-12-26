import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowingCard from './FollowingCard';
import mockUsers from '../../../mockData/milestone1/451_users.json';

type FollowingModalProps = {
    show: boolean;
    setShow: () => void;
    followingData: any;
    handleUnfollow: (targetId: number) => void
    handleFollow: (targetId: number) => void
};

const FollowingModal: React.FC<FollowingModalProps> = ({ show, setShow, followingData, handleUnfollow, handleFollow}) => {
    return (
        <Modal show={show} centered className="Following-modal" onHide={setShow}>
            <Modal.Header closeButton>
                <Modal.Title className="text-center font-weight-bold">Following</Modal.Title>
            </Modal.Header>
            <Modal.Body style={{ maxHeight: '400px', overflowY: 'auto' }}>
                <Row className="Following-list">
                    {followingData?.map((following: any) => (
                        <Col key={following.id} md={12} className="mb-3">
                            <FollowingCard user={following} unfollow={handleUnfollow} follow={handleFollow}/>
                        </Col>
                    ))}
                </Row>
                <Row className="justify-content-center">
                    <Col md={2} className="text-center">
                        <Button
                            className="close-button"
                            variant="link"
                            onClick={setShow}
                        >
                        </Button>
                    </Col>
                </Row>
            </Modal.Body>
        </Modal>
    );
};

export default FollowingModal;
