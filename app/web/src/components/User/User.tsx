import React from 'react';
import PropTypes from 'prop-types';

interface UserProps {
    profilePicture: string;
    firstName: string;
    lastName: string;
    userName: string;
}

const User: React.FC<UserProps> = ({ profilePicture, firstName, lastName, userName }) => {
    return (
        <div className="user-container card mt-3 mb-1">
            <div className="row g-0">
                <div className="col-4 justify-content-center my-4" style={{ maxHeight: '80px', maxWidth: '80px' }}>
                    <img
                        src={profilePicture}
                        alt="Profile"
                        className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                        style={{ borderRadius: '50%' }}
                    />
                </div>
                <div className="col-8">
                    <div className="row card-body">
                        <div className="col-10 m-auto">
                            <h5 className="card-title">{`${firstName} ${lastName}`}</h5>
                            <p className="card-text text-body-secondary">@{userName}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

User.propTypes = {
    profilePicture: PropTypes.string.isRequired,
    firstName: PropTypes.string.isRequired,
    lastName: PropTypes.string.isRequired,
    userName: PropTypes.string.isRequired,
};

export default User;
