import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { useSearchGlobally } from "../../hooks/useSearch";
import { useAuth } from "../../contexts/AuthContext";
import { Container, Row, Col, ListGroup, Card } from "react-bootstrap";
import PostPreviewCard from "../Post/PostSmallPreview/PostPreviewCard";

const SearchResults = () => {
  const { searchTerm } = useParams();

  const [userResults, setUserResults] = useState([]);
  const [interestAreaResults, setInterestAreaResults] = useState([]);
  const [postResults, setPostResults] = useState([]);

  const { mutate: searchGlobally } = useSearchGlobally({});
  const { axiosInstance } = useAuth();
  useEffect(() => {
    searchGlobally(
      {
        searchKey: searchTerm || "",
        axiosInstance: axiosInstance,
      },
      {
        onSuccess: (data) => {
          setUserResults(data.users);
          setInterestAreaResults(data.interestAreas);
          setPostResults(data.posts);
        },
        onError: (error) => {
          console.log(error);
        },
      }
    );
  }, [searchTerm]);

  const navigate = useNavigate();
  function handleInterestAreaClick(id: any): void {
    navigate(`/interest-area/${id}`);
  }

  function handleUserClick(id: any): void {
    navigate(`/profile/${id}`);
  }

  function handlePostClick(id: any): void {
    navigate(`/posts/${id}`);
  }

  return (
    <Container className="mt-3">
      <Row>
        <Col md={3} className="mb-3">
          <h3>Bunches</h3>
          <ListGroup>
            {interestAreaResults.map((area: any) => (
              <ListGroup.Item
                key={area.id}
                onClick={() => handleInterestAreaClick(area.id)}
                style={{ cursor: "pointer" }}
                action
              >
                <Row>
                  <Col>{area.title}</Col>
                  <Col className="ml-auto">
                    {area.accessLevel === "PUBLIC" ? (
                      <img
                        src="/assets/public.png"
                        className="ml-auto"
                        alt="Logo"
                        style={{ width: "20px" }}
                      />
                    ) : (
                      <img
                        src="/assets/private.png"
                        alt="Logo"
                        style={{ width: "20px" }}
                      />
                    )}
                  </Col>
                </Row>
              </ListGroup.Item>
            ))}
          </ListGroup>
          <h3 className="mt-3">Profiles</h3>
          {userResults && userResults.length > 0 && (
            <ListGroup>
              {userResults.map((user: any) => (
                <ListGroup.Item
                  key={user.id}
                  onClick={() => handleUserClick(user.id)}
                  action
                >
                  <Card>
                    <Card.Body>
                      <Card.Title>{user.name}</Card.Title>
                      <Card.Subtitle className="mb-2 text-muted">
                        @{user.username}
                      </Card.Subtitle>
                    </Card.Body>
                  </Card>
                </ListGroup.Item>
              ))}
            </ListGroup>
          )}
        </Col>
        <Col md={9} className="mb-3">
          <h2>Spots</h2>
          {postResults && postResults.length > 0 && (
            <ListGroup>
              {postResults.map((post: any, index: number) => (
                <div
                  key={index}
                  style={{ cursor: "pointer" }}
                  onClick={() => handlePostClick(post.id)}
                >
                  <PostPreviewCard post {...post}></PostPreviewCard>
                </div>
              ))}
            </ListGroup>
          )}
        </Col>
      </Row>
    </Container>
  );
};

export default SearchResults;
