import React from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import mockPosts from "../../mockData/milestone1/451_posts.json";
import mockDetailedIA from "../../mockData/milestone1/451_detailed_ia.json";
import mockInterestAreas from "../../mockData/milestone1/451_interest_areas.json";
import mockUsers from "../../mockData/milestone1/451_users.json";
import { useParams } from "react-router-dom";
import Tag from "../../components/Tag/Tag";

const ViewInterestArea = () => {
  const { iaId } = useParams();

  type postTypes = {
    id: number,
    user_id: number,
    ia_ids: number[],
    source_link: string,
    content: string,
    created_at: string
};

  type iaTypes = {
    id: number,
    are_name: string,
    related_ias: number[],
    ia_tags: string[]
  }

  const getUserName = (post: postTypes): string | undefined => {
    return mockUsers.find(
        (user) => user.id === post.user_id)?.name;
  }
  const createInterestAreaListOfPost = (postIAs: number[]) => {
    return mockInterestAreas.filter((interestArea) => {
        return postIAs.find((postIA) => postIA === interestArea.id);
    })
  };

  const createInterestAreaListOfIA = (related_ias: number[]) => {
    return mockInterestAreas.filter((interestArea) => {
        return related_ias.find((related_ia) => related_ia === interestArea.id);
    })
  };

  const iaPosts = mockPosts.filter((post) => post.ia_ids.includes(Number(iaId)));
  const selectedIA = mockDetailedIA.find((ia) => ia.id.toString() === iaId);

  if (!selectedIA) {
    return <p>Interest Area not found </p>;
  }

  return (
    <div style={{ display: "flex"}}>
      <div className="container mt-4" style={{width:"75%", height: "100%", borderRight:"solid #C2C2C2",padding: "50px"}}>
        <h1 className="fw-bold" style={{ marginBottom: "50px",display: "inline-block",padding: "10px 20px 10px 20px", textTransform: "uppercase", background: "#E0E0E0", borderRadius: "20px"}}>{selectedIA.area_name}</h1>
        {iaPosts.map((post) => (
          <div key={post.id} style={{ marginBottom: "35px"}}>
          {/*<PostPreviewCard*/}
          {/*  */}
          {/*  post={post}*/}
          {/*  userName={getUserName(post)}*/}
          {/*  tags={createInterestAreaListOfPost(post.ia_ids)}*/}
          {/* />*/}
          </div>
        ))}
      </div>
      
      <div style={{width:"25%", margin: "50px"}}>
        <div style={{marginBottom: "70px"}}>
          <h2 style={{marginLeft: "20px"}}>IA Tags:</h2>
          <hr className="solid" style={{borderTop: "3px solid black"}}></hr>
          {selectedIA.ia_tags.map((ia_tag, index) => (
            <div key={index} style={{display: "flex", alignItems:"center", justifyContent: "center", background: "#C2C2C2", borderRadius: "10px", width: "224px", fontSize: "20px",height: "45px", margin: "15px"}}>#{ia_tag}</div>
          ))}
        </div>
        <div>
          <h2>Related IA&apos;s</h2>
          <hr className="solid" style={{borderTop: "3px solid black"}}></hr>
        {createInterestAreaListOfIA(selectedIA.related_ias).map((area,index) =>
          <div key={index} style={{display: "flex", alignItems:"center", justifyContent: "center", background: "#C2C2C2", borderRadius: "10px", width: "224px", fontSize: "20px",height: "45px", margin: "15px"}}>{area.area_name} </div>
                  )}
        </div>
      </div>
    </div>
  );
};

export default ViewInterestArea;
