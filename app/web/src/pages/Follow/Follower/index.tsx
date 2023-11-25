import React, { useState } from 'react';
import FollowerModal from '../../../components/Follow/Follower/FollowerModal';

const FollowerPage: React.FC = () => {
    const [showFollowerModal, setShowFollowerModal] = useState(true);
    const handleFollowerModal = () =>{
        setShowFollowerModal(!showFollowerModal);
    }

    const closeFollowerModal = () => {
        setShowFollowerModal(true);//bunu sonra false yap
    };

    return (
        <>
            <FollowerModal show={showFollowerModal } setShow={handleFollowerModal} />
        </>
    );
};

export default FollowerPage;