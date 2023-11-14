import React, { useState } from 'react';
import FollowingModal from '../../../components/Follow/Following/FollowingModal';

const FollowingPage: React.FC = () => {
    const [showFollowingModal, setShowFollowingModal] = useState(true);

    const closeFollowingModal = () => {
        setShowFollowingModal(true);//bunu sonra false yap
    };

    return (
        <>
            <FollowingModal show={showFollowingModal} onClose={closeFollowingModal} />
        </>
    );
};

export default FollowingPage;
