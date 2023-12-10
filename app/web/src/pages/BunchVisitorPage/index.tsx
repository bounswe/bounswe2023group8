import React from "react";
import { Container, Row, Col, Card } from "react-bootstrap";
import PostPreviewCard from "../../components/Post/ModifiedPostPreviewCard";
import Tag from "../../components/Tag/Tag";
import mockPosts from "../../mockData/bunch_visitor_sample/451_posts_visitor.json";
import mockBunchTags from "../../mockData/bunch_visitor_sample/451_bunch_tags.json";
import mockRelatedBunches from "../../mockData/bunch_visitor_sample/451_related_bunches.json";

type BunchVisitorProps = {};

const BunchVisitor: React.FC<BunchVisitorProps> = () => {
  const backgroundImageUrl =
    "https://img.freepik.com/premium-vector/hand-drawn-vector-illustration-brain-head-open-pattern-white-background_630651-117.jpg?w=2000";

  const posts = mockPosts;
  const bunchTags = mockBunchTags;
  const relatedBunches = mockRelatedBunches;

  return (
    <Container
      fluid
      style={{
        height: "100vh",
        backgroundImage: `url(${backgroundImageUrl})`,
        backgroundSize: "cover",
      }}
    >
      <Row>
        {/* Left Part */}
        <Col xs={8}>
          {/* Interest Area Card */}
          <Card
            className="mt-3 mb-3 bg-light text-center rounded-4 d-inline-block"
            style={{ minHeight: "fit-content" }}
          >
            <Card.Body>
              <h4 className="card-title">UNDERSTANDING PROCRASTINATION</h4>
            </Card.Body>
          </Card>

          {/* Scrollable Post Preview Cards */}
          <div style={{ overflowY: "auto", height: "100vh" }}>
            {/* {posts.map((post, index) => (
                            <PostPreviewCard
                                key={index}
                                post={{
                                    headline: post.headline,
                                    image_link: post.image_link,
                                    source_link: post.source_link,
                                    content: post.content,
                                }}
                            />
                        ))} */}
          </div>
        </Col>

        {/* Right Part */}
        <Col xs={3} className="text-center">
          <div style={{ height: "100px" }} />
          <Card
            className="mt-3 mb-3 bg-light text-center rounded-4 d-inline-block"
            style={{ minHeight: "fit-content" }}
          >
            <Card.Body>
              <h5 className="card-title">Bunch Tags</h5>
            </Card.Body>
          </Card>
          <div className="mb-3">
            {bunchTags.map((tag, index) => (
              <Tag key={index} className="mb-3" label={tag.name} />
            ))}
          </div>
          {/* Space */}
          <div style={{ height: "30px" }} />
          <Card
            className="mt-3 mb-3 bg-light text-center rounded-4 d-inline-block"
            style={{ minHeight: "fit-content" }}
          >
            <Card.Body>
              <h5 className="card-title">Related Bunches</h5>
            </Card.Body>
          </Card>
          <div className="mb-3">
            {relatedBunches.map((tag, index) => (
              <Tag key={index} className="mb-3" label={tag.name} />
            ))}
          </div>
        </Col>
      </Row>
    </Container>
  );
};

export default BunchVisitor;
