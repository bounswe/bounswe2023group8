import React from 'react';

interface InterestArea {
    id: number;
    title: string;
}

interface InterestAreaCardProps {
    interestArea: InterestArea;
}

const InterestAreaCard: React.FC<InterestAreaCardProps> = ({interestArea}) => {
    return (
        <a href={`/interest-area/${interestArea.id}`}>
            <div className="card"
                 style={{
                     backgroundColor: "#CDCFCF",
                     border: "none",
                     paddingTop: "2px",
                     margin: "20px",
                     height: "60px",
                     borderRadius: "20px"
                 }}>
                <div className="card-body">
                    <h5 className="card-title"> {interestArea.title}</h5>
                </div>
            </div>
        </a>
    );
};

export default InterestAreaCard;
