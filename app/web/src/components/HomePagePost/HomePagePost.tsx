import React from 'react';
import PropTypes from 'prop-types';

interface Tag {
    id: number;
    name: string;
}

interface HomePagePostProps {
    heading: string;
    link: string;
    description: string;
    creator: {
        name: string;
        surname: string;
    };
    tagsAbove: Tag[];
    tagsBelow: Tag[];
}

const HomePagePost: React.FC<HomePagePostProps> = ({
                                                       heading,
                                                       link,
                                                       description,
                                                       creator,
                                                       tagsAbove,
                                                       tagsBelow,
                                                   }) => {
    return (
        <div className="container mt-3">
            {/* Right Part */}
            <div className="row">
                <div className="col-md-8">
                    <div className="card">
                        <div className="card-body">
                            <h2 className="card-title">{heading}</h2>
                            <a href={link} target="_blank" rel="noopener noreferrer" className="card-link">
                                {link}
                            </a>
                            <p className="card-text">{description}</p>
                            <p className="card-text">
                                <small className="text-muted">Created by {`${creator.name} ${creator.surname}`}</small>
                            </p>
                        </div>
                    </div>
                </div>

                {/* Left Part */}
                <div className="col-md-4">
                    <div className="tags-container above">
                        {tagsAbove.map((tag) => (
                            <div key={tag.id} className="tag badge bg-primary me-2">
                                {tag.name}
                            </div>
                        ))}
                    </div>
                    <div className="tags-container below">
                        {tagsBelow.map((tag) => (
                            <div key={tag.id} className="tag badge bg-secondary me-2">
                                {tag.name}
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

// @ts-ignore
HomePagePost.propTypes = {
    heading: PropTypes.string.isRequired,
    link: PropTypes.string.isRequired,
    description: PropTypes.string.isRequired,
    creator: PropTypes.shape({
        name: PropTypes.string.isRequired,
        surname: PropTypes.string.isRequired,
    }).isRequired,
    tagsAbove: PropTypes.array.isRequired as PropTypes.Validator<Tag[]>,
    tagsBelow: PropTypes.array.isRequired as PropTypes.Validator<Tag[]>,
};

export default HomePagePost;