import React from 'react';

const getRandomPastelColor = () => {
    const letters = '6789AB'; // Exclude darker shades
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * letters.length)];
    }
    return color;
};

type ModifiedPostPreviewCardProps = {
    post: {
        headline: string;
        source_link: string;
        content: string;
        image_link?: string; // Optional image_link
    };
};

const ModifiedPostPreviewCard: React.FC<ModifiedPostPreviewCardProps> = (props) => {
    const cardStyle: React.CSSProperties = {
       // backgroundColor: "white"
    };

    return (
        <div className="card mb-3 bg-primary-subtle" style={cardStyle}>
            <div className="row g-0">
                {props.post.image_link && (
                    <div className="col-md-4">
                        <div className="card-body">
                            <div className="text-center mb-3">
                                <img
                                    src={props.post.image_link}
                                    alt={`Post Image`}
                                    className="img-fluid"
                                    style={{ maxWidth: '200px' }}
                                />
                            </div>
                        </div>
                    </div>
                )}
                <div className={props.post.image_link ? 'col-md-8' : 'col-12'}>
                    <div className="card-body">
                        {props.post.headline && (
                            <h6 className="card-title font-weight-bold truncate-text-4 mb-3">{props.post.headline}</h6>
                        )}
                        {props.post.content && (
                            <div>
                                <p className="card-text mb-3">{props.post.content}</p>
                            </div>
                        )}
                        <p>
                            <a href={props.post.source_link} className="link-primary">
                                {props.post.source_link}
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ModifiedPostPreviewCard;
