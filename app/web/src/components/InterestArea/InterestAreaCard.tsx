import React from 'react';

interface InterestArea {
  id: number;
  area_name: string;
}

interface InterestAreaCardProps {
  interestArea: InterestArea;
}

const InterestAreaCard: React.FC<InterestAreaCardProps> = ({ interestArea }) => {
  return (
    <div className="card" style={{ backgroundColor: "#F1F1F1", border: "none", paddingTop: "2px", margin: "20px", height: "60px"}}>
      <div className="card-body">
        <h5 className="card-title">{interestArea.area_name}</h5>
      </div>
    </div>
  );
};

export default InterestAreaCard;
