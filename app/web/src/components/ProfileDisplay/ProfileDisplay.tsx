import React from 'react';
import { Col, Row } from 'react-bootstrap';

type ProfileDisplayProps = {
    user: {
        id: number;
        name: string;
        nickname: string;
        user_profile_image: string;
    };
    style: object;
    className: string;
};

const ProfileDisplay: React.FC<ProfileDisplayProps> = ({
                                                           user: { name, nickname, user_profile_image },
                                                           style,
                                                           className,
                                                       }) => {
    return (
        <div className={`card mt-3 mb-1 ${className}`} style={style}>
            <Row className="g-0">
                <Col className="col-12 text-center my-2"> {/* Decreased my-4 to my-2 */}
                    <img
                        src={user_profile_image}
                        className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                        style={{ borderRadius: '50%', maxHeight: '120px', maxWidth: '120px' }}
                        alt={`${name} PP`}
                    />
                </Col>
                <Col className="col-12 text-center">
                    <Row className="card-body">
                        <Col className="col-12 m-auto">
                            <h5 className="card-title">{name}</h5>
                            <p className="card-text text-body-secondary" style={{ margin: 0 }}>{/* Added style to remove default margin */}
                                @{nickname}
                            </p>
                        </Col>
                    </Row>
                </Col>
            </Row>
        </div>
    );
};

export default ProfileDisplay;
