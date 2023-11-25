import React from 'react';
import { Modal, Button, Col, Row } from 'react-bootstrap';
import FollowerCard from './FollowerCard';
import mockUsers from '../../../mockData/milestone1/451_users.json';

type FollowerModalProps = {
    show: boolean;
    onClose: () => void;
};
const FollowerModal: React.FC<FollowerModalProps> = ({ show, onClose }) => {
    const followersData = mockUsers.slice(0, 4);

    return (
        <Modal
            show={show}
            onHide={onClose}
            centered
            className="follower-modal"
        >
            <Modal.Header closeButton className="text-center">
                <Modal.Title className="text-center font-weight-bold">Followers</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                {followersData.map((follower) => (
                    <FollowerCard key={follower.id} user={follower} style={{ margin: '0 auto' }} className="mb-3" />
                ))}
            </Modal.Body>
        </Modal>
    );
};

export default FollowerModal;
