import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { useSearchGlobally } from "../../hooks/useSearch";
import { useAuth } from "../../contexts/AuthContext";
import { Container, Row, Col, ListGroup, Card } from "react-bootstrap";

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
    navigate(`/interest-areas/${id}`);
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
                onClick={() => handleInterestAreaClick(area.id)} // Set the click handler
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
                <ListGroup.Item key={user.id} action>
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
              {postResults.map((post: any) => (
                <ListGroup.Item key={post.id}>
                  <Card>
                    <Card.Body>
                      <Card.Title>{post.title}</Card.Title>
                      <Card.Subtitle className="mb-2 text-muted">
                        Spotted by {post.enigmaUser.username} -{" "}
                        {post.createTime}
                      </Card.Subtitle>
                      <Card.Link href={post.sourceLink}>Source Link</Card.Link>
                    </Card.Body>
                  </Card>
                </ListGroup.Item>
              ))}
            </ListGroup>
          )}
        </Col>
      </Row>
    </Container>
  );
};

export default SearchResults;
