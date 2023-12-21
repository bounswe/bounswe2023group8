import React, { useState } from "react";
import { Col, Row } from "react-bootstrap";
import SpanWithOnClick from "../shared/SpanWithOnClick/SpanWithOnClick";
import FollowerModal from "../Follow/Follower/FollowerModal";
import FollowingModal from "../Follow/Following/FollowingModal";
import { useReportAnIssue } from "../../hooks/useModeration";
import { useAuth } from "../../contexts/AuthContext";

type ProfileHeaderProps = {
  user: {
    id: number;
    name: string;
    username: string;
    followers: number;
    following: number;
    user_profile_image: string;
  };
  style: object;
  className: string;
};

const ProfileHeader = ({
  user: { id, name, username, followers, following, user_profile_image },
  style,
  className,
}: ProfileHeaderProps) => {
  const [showFollowerModal, setShowFollowerModal] = useState(false);
  const [showFollowingModal, setShowFollowingModal] = useState(false);
  const [reportReason, setReportReason] = useState("");
  const [showReport, setShowReport] = useState(false);

  const { axiosInstance } = useAuth();

  const { mutate: reportAnIssue } = useReportAnIssue({
    axiosInstance,
    issue: {
      entityId: id,
      entityType: "user",
      reason: reportReason,
    },
  });

  const reportUser = () => {
    reportAnIssue({
      axiosInstance,
      issue: {
        entityId: id,
        entityType: "user",
        reason: reportReason,
      },
    });
  };

  const handleFollowerModal = () => {
    setShowFollowerModal(!showFollowerModal);
  };

  const handleFollowingModal = () => {
    setShowFollowingModal(!showFollowingModal);
  };

  return (
    <div
      style={{
        background: "#EEF0EB",
        display: "flex",
        alignItems: "center",
      }}
    >
      <div className={`card mt-3 mb-1 ${className}`} style={style}>
        <Row className="g-0">
          <Col
            className="col-4 justify-content-center my-4"
            style={{ maxHeight: "80px", maxWidth: "80px" }}
          >
            {user_profile_image ? (
              <img
                src={user_profile_image}
                className="rounded-circle img-fluid object-fit-cover h-100 w-100"
                style={{ borderRadius: "50%" }}
                alt="PP goes here"
              />
            ) : (
              <h1 className="bi bi-person-circle display-1 mx-4"></h1>
            )}
          </Col>
          <Col className="col-8">
            <Row className="card-body">
              <Col className="col-10 m-auto">
                <h5 className="card-title" style={{ fontSize: "2rem" }}>
                  {name}
                </h5>
                <p
                  className="card-text text-body-secondary"
                  style={{ fontSize: "1.5rem" }}
                >
                  @{username}
                </p>

                <Row className="justify-content-between">
                  <Col className="card-text" style={{ fontSize: "1.2rem" }}>
                    <SpanWithOnClick
                      className={""}
                      text={`${followers} followers`}
                      onClick={handleFollowerModal}
                    />
                  </Col>
                  <Col className="card-text" style={{ fontSize: "1.2rem" }}>
                    <SpanWithOnClick
                      className={""}
                      text={`${following} following`}
                      onClick={handleFollowingModal}
                    />
                  </Col>
                </Row>
              </Col>
              {/*<Col className="col-2 m-auto">*/}
              {/*    <p className="fs-5 bi-hand-thumbs-up-fill " style={{color: 'green'}}>{all_time_likes}</p>*/}
              {/*    <p className="fs-5 bi-hand-thumbs-down-fill text-danger">{all_time_dislikes}</p>*/}
              {/*</Col>*/}
            </Row>
          </Col>
        </Row>
        <FollowerModal show={showFollowerModal} setShow={handleFollowerModal} />
        <FollowingModal
          show={showFollowingModal}
          setShow={handleFollowingModal}
        />
      </div>
      <Col>
        <div className="mx-2 my-3 w-75 WA-theme-bg-light d-flex justify-content-center align-items-center rounded-5">
          {showReport ? (
            <>
              <input
                type="text"
                className="form-control m-4 "
                placeholder="Please write a reason"
                onChange={(e) => setReportReason(e.target.value)}
              ></input>
              <div className="d-flex mx-3">
                <button onClick={() => reportUser()} className="btn">
                  Submit
                </button>
                <button
                  onClick={() => setShowReport(!showReport)}
                  className="btn"
                >
                  Close
                </button>
              </div>
            </>
          ) : (
            <>
              <button
                onClick={() => setShowReport(!showReport)}
                className="btn mx-3 rounded-5"
              >
                Report
              </button>
            </>
          )}
        </div>
      </Col>
    </div>
  );
};

export default ProfileHeader;
