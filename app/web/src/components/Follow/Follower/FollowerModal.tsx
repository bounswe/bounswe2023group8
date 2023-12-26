import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowerCard from './FollowerCard';
import mockUsers from '../../../mockData/milestone1/451_users.json';
import {EnigmaUser} from "../../../pages/InterestAreaViewPage";

type FollowerModalProps = {
    show: boolean;
    setShow: () => void;
    followerData: any;
    handleFollow: (targetId: number) => void;
};

const FollowerModal: React.FC<FollowerModalProps> = ({ show, setShow, followerData, handleFollow}) => {

    return (
        <Modal show={show} centered className="follower-modal" onHide={setShow}>
            <Modal.Header closeButton>
                <Modal.Title className="text-center font-weight-bold">Followers</Modal.Title>
            </Modal.Header>
            <Modal.Body style={{ maxHeight: '400px', overflowY: 'auto' }}>
                <Row className="follower-list">
                    {followerData?.map((follower: any) => (
                        <Col key={follower.id} md={12} className="mb-3">
                            <FollowerCard user={follower} follow={handleFollow} />
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

export default FollowerModal;
