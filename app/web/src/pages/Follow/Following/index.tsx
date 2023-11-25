import React, { useState } from 'react';
import FollowingModal from '../../../components/Follow/Following/FollowingModal';

const FollowingPage: React.FC = () => {
    const [showFollowingModal, setShowFollowingModal] = useState(true);

    const closeFollowingModal = () => {
        setShowFollowingModal(true);//bunu sonra false yap
    };

    const handleFollowingModal = () =>{
        setShowFollowingModal(!showFollowingModal);
    }

    return (
        <>
            <FollowingModal show={showFollowingModal} setShow={handleFollowingModal}/>
        </>
    );
};

export default FollowingPage;