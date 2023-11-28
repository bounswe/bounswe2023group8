import React, {useState} from "react";
import { format } from "date-fns";
import Tag from "../Tag/Tag";
import mockUsers from "../../mockData/milestone1/451_users.json";
import { Col, Row } from "react-bootstrap";
import { Post, EnigmaUser, Geolocation, InterestArea, WikiTag} from "../../pages/InterestAreaViewPage";
import LocationViewer from "../Geolocation/LocationViewer";

export type DetailedPostCardProps = {
  post: Post
}

const  DetailedPostCard = (props: DetailedPostCardProps) => {
  const [locationModalShow, setLocationModalShow] = useState(false);
  const handleLocationModalShow = () => {
    setLocationModalShow(!locationModalShow);
  }
  const { post } = props;
    return (
      <div
        style={{
          backgroundColor: "#CDCFCF",
          padding: "40px",
          margin: "50px",
          borderRadius: "10px",
        }}
      >
        <h3>{post.interestArea.title}</h3>
        <div
          className={`card mt-3 mb-1`}
          style={{ backgroundColor: "#FFFAF6" }}
        >
          <Row className="g-0">
            <Col
              className=" justify-content-center my-4"
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
                  <h5 className="card-title">{post.enigmaUser.name}</h5>
                  <div className="card-text" style={{ marginBottom: "10px" }}>
                    @{post.enigmaUser.username}
                  </div>

                  {/* Follow button */}
                  <div className="d-flex justify-content-between">
                    <button className="btn btn-primary">Follow</button>
                    <button className="btn btn-primary" onClick={handleLocationModalShow}>View Location</button>
                  </div>
                </Col>
              </Row>
            </Col>
          </Row>


          <div style={{ display: "flex", flexDirection: "row" }}>
            <div className="col-12" style={{ width: "80%" }}>
            
              <div className="card-body">
              <p className="text-body-secondary" style={{textAlign:"right"}}>
                {format(new Date(post.createTime), "dd/MM/yyyy")}</p>
                <h4 className="card-title">{post.title}</h4>
                
                <a href={""} className="link-primary">
                  {post.sourceLink}
                </a>
                <p className="card-text">{post.content}</p>
                <p className="card-text justify-content-between d-flex">
                  <small className="text-body-secondary">
                    Spotted by {post.enigmaUser.name}
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
                      51
                    </p>
                    <p className="fs-5 bi-hand-thumbs-down-fill text-danger">
                      2
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
                {post.wikiTags.map((tag) => (
                  <Tag
                    className={""}
                    key={`${tag.id}`}
                    name={tag.label}
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
        <LocationViewer showLocationViewerModal={locationModalShow}
                        setShowLocationViewerModal={handleLocationModalShow} locationData={post.geolocation}></LocationViewer>
      </div>
    );
}

export default DetailedPostCard;
