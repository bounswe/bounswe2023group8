import React from "react";
import { format } from "date-fns";
import Tag from "../Tag/Tag";
import mockUsers from "../../mockData/milestone1/451_users.json";
import { Col, Row } from "react-bootstrap";

type DetailedPostCardProps = {
  post: {
    id: number;
    user_id: number;
    ia_ids: number[];
    header: string;
    source_link: string;
    content: string;
    source: string;
    date: string;
    spotted_at: string; // "2023-10-25 10:30:00"
    liked: number;
    disliked: number;
  };
  userName: string | undefined;
  interestAreas: {
    id: number;
    area_name: string;
  }[];
};

class DetailedPostCard extends React.Component<DetailedPostCardProps> {
  render() {
    const {
      interestAreas,
      post: {
        header,
        content,
        ia_ids,
        spotted_at,
        date,
        source_link,
        liked,
        disliked,
        source,
      },
      userName,
    } = this.props;

    const bunchNames = ia_ids.map((ia_id) => {
      const interestArea = interestAreas.find((ia) => ia.id === ia_id);
      return interestArea ? interestArea.area_name : null;
    });

    return (
      <div
        style={{
          backgroundColor: "#CDCFCF",
          padding: "40px",
          margin: "50px",
          borderRadius: "10px",
        }}
      >
        <h3>{bunchNames}</h3>
        <div
          className={`card mt-3 mb-1`}
          style={{ backgroundColor: "#FFFAF6" }}
        >
          <Row className="g-0">
            <Col
              className="col-4 justify-content-center my-4"
              style={{
                maxHeight: "80px",
                maxWidth: "80px",
                marginLeft: "20px",
              }}
            >
              <img
                src={mockUsers[0].user_profile_image}
                className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                style={{ borderRadius: "50%" }}
                alt="Furkan PP"
              />
            </Col>
            <Col className="col-8">
              <Row className="card-body">
                <Col className="col-10">
                  <h5 className="card-title">{mockUsers[0].name}</h5>
                  <div className="card-text" style={{ marginBottom: "10px" }}>
                    @{mockUsers[0].nickname}
                  </div>

                  {/* Follow button */}
                  <button className="btn btn-primary">Follow</button>
                </Col>
              </Row>
            </Col>
          </Row>


          <div style={{ display: "flex", flexDirection: "row" }}>
            <div className="col-12" style={{ width: "80%" }}>
            
              <div className="card-body">
              <p className="text-body-secondary" style={{textAlign:"right"}}>{spotted_at}</p>

                <h4 className="card-title">{header}</h4>
                
                <a href={source_link} className="link-primary">
                  {source_link}
                </a>
                <p className="card-text">{content}</p>
                <p>
                  <p>Source: {source}</p>
                  <p>Date: {date}</p>
                </p>
                <p className="card-text justify-content-between d-flex">
                  <small className="text-body-secondary">
                    Spotted by {userName}
                  </small>
                </p>

                <Row className="justify-content-between">
                  <Col className="d-flex">
                    <p
                      className="fs-5 bi-hand-thumbs-up-fill"
                      style={{
                        color: "green",
                        marginLeft: "2px",
                        marginRight: "15px",
                      }}
                    >
                      {liked}
                    </p>
                    <p className="fs-5 bi-hand-thumbs-down-fill text-danger">
                      {disliked}
                    </p>
                    <button className="btn btn-danger ms-4 ms-auto">Report Post</button>
                  </Col>
                </Row>
              </div>
            </div>
            <div
              className="col-3 container d-flex p-1 m-0 align-self-start"
              style={{ width: "20%" }}
            >
              <div className="vr my-3 col-1"></div>
              <div
                className="mx-auto align-self-center overflow-y-auto"
                style={{ maxHeight: "200px" }}
              >
                {interestAreas.map((area) => (
                  <Tag
                    className={""}
                    key={`${area.id}`}
                    name={area.area_name}
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default DetailedPostCard;
