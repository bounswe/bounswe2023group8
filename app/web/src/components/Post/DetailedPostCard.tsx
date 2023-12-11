import React, {useEffect, useState} from "react";
import { format } from "date-fns";
import Tag from "../Tag/Tag";
import mockUsers from "../../mockData/milestone1/451_users.json";
import { Col, Row } from "react-bootstrap";
import { Post, EnigmaUser, Geolocation, InterestArea, WikiTag} from "../../pages/InterestAreaViewPage";
import LocationViewer from "../Geolocation/LocationViewer";
import {useAuth} from "../../contexts/AuthContext";
import {Link} from "react-router-dom";

export type DetailedPostCardProps = {
  post: Post
}

type Annotation = {
  startIndex: number,
  endIndex: number,
  content: string,
}

const  DetailedPostCard = (props: DetailedPostCardProps) => {
  const { userData} = useAuth();
  const [locationModalShow, setLocationModalShow] = useState(false);
  const handleLocationModalShow = () => {
    setLocationModalShow(!locationModalShow);
  }
  
  const [annotations, setAnnotations] = useState<Annotation[]>([]);
  const [mergedRanges, setMergedRanges] = useState<{start: number, end: number}[]>([]);

  useEffect(() => {
    // set annotations by api
    // mock data for now
    const ann1 : Annotation = {
      startIndex: 0,
      endIndex: 10,
      content: "Ankara",
    }
    const ann2 : Annotation = {
      startIndex: 45,
      endIndex: 50,
      content: "Ankara",
    }
    const ann4 : Annotation = {
      startIndex: 40,
      endIndex: 50,
      content: "Ankara",
    }
    const ann5 : Annotation = {
      startIndex: 45,
      endIndex: 70,
      content: "Ankara",
    }
    const ann6 : Annotation = {
      startIndex: 5,
      endIndex: 20,
      content: "Ankara",
    }
    setAnnotations([ann1, ann2, ann4, ann5, ann6]);
  }, []);

  useEffect(() => {
    if (annotations.length == 0) return;
      setMergedRanges(mergeOverlappingRanges(annotations))
  }, [annotations])

  function mergeOverlappingRanges(annotations: Annotation[]) {
    annotations.sort((a, b) => a.startIndex - b.startIndex);
  
    const mergedRanges = [];
  
    let currentStartIndex = annotations[0].startIndex;
    let currentEndIndex = annotations[0].endIndex;
  
    for (let i = 1; i < annotations.length; i++) {
      const nextStartIndex = annotations[i].startIndex;
      const nextEndIndex = annotations[i].endIndex;
  
      if (currentEndIndex >= nextStartIndex) {
        // Merge overlapping ranges
        currentEndIndex = Math.max(currentEndIndex, nextEndIndex);
      } else {
        // Add the merged range
        mergedRanges.push({ start: currentStartIndex, end: currentEndIndex });
  
        // Update currentStartIndex and currentEndIndex
        currentStartIndex = nextStartIndex;
        currentEndIndex = nextEndIndex;
      }
    }
  
    // Add the last merged range
    mergedRanges.push({ start: currentStartIndex, end: currentEndIndex });
  
    return mergedRanges;
  }

  const renderHighlightedText = () => {
    let currentPosition = 0;
    const result = [];

    mergedRanges.forEach((range, index) => {
      const { start, end } = range;

      // Get the text between the current position and the start index
      const beforeHighlight = post.content.slice(currentPosition, start);

      // Get the highlighted text
      const highlightedText = post.content.slice(start, end);

      // Update the current position to the end index for the next iteration
      currentPosition = end;

      // Add the non-highlighted part to the result
      if (beforeHighlight) {
        result.push(<span key={`non-highlighted-${index}`}>{beforeHighlight}</span>);
      }

      // Add the highlighted part to the result
      result.push(<span onMouseEnter={() => {hoverAnnotation(start, end)}} key={`highlighted-${index}`} className="highlighted-text" style={{backgroundColor: "red"}}>{highlightedText}</span>);
    });

    // Add any remaining non-highlighted text after the last annotation
    if (currentPosition < post.content.length) {
      result.push(<span key={`non-highlighted-last`}>{post.content.slice(currentPosition)}</span>);
    }

    return result;
  };

  const hoverAnnotation = (startIndex: number, endIndex: number) => {
    const annotationsInRange : Annotation[] = [];
    annotations.forEach((annotation) => {
      if (annotation.startIndex >= startIndex && annotation.endIndex <= endIndex) {
        annotationsInRange.push(annotation);
      }
    });
    console.log(annotationsInRange)
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

                <p className="card-text">{renderHighlightedText()}</p>

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
                    {userData.id == post.enigmaUser.id
                    ? <Link to={`/update_post/${post.id}`} state={{post: post}}
                            className="btn btn-primary ms-4 ms-auto">Update Post</Link>
                    : <button className="btn btn-danger ms-4 ms-auto">Report Post</button>
                    }

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
                    label={tag.label}
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
