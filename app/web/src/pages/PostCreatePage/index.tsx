import React, { useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import PostCreateCard, {
  CreatePostFormData,
} from "../../components/Post/Create/PostCreateCard";
import { SelectedLocationFormData } from "../../components/Geolocation/LocationPicker";
import { useCreatePost } from "../../hooks/usePost";
import {useLocation, useNavigate} from "react-router-dom";
import DetailedPostCardPreview from "../../components/Post/DetailedPostCardPreview";

const CreatePost = () => {
  const { axiosInstance } = useAuth();
  const defaultPostDetails: CreatePostFormData = {
    interestAreaId: -1,
    title: "",
    content: "",
    wikiTags: [],
    label: 1,
    sourceLink: ""
  };

  const defaultLocationDetails: SelectedLocationFormData = {
    latitude: 41,
    longitude: 29,
    address: "",
    locationSelected: false,
  };

  const propsFromParent = useLocation();
  const {interestAreaTitle} = propsFromParent.state;
  const interestAreaId = parseInt(propsFromParent.state.interestAreaId);
  const [postDetails, setPostDetails] = useState(defaultPostDetails);
  const [locationDetails, setLocationDetails] = useState(
    defaultLocationDetails
  );

  const handleInputChange = (
    e:
      | React.ChangeEvent<HTMLInputElement>
      | React.ChangeEvent<HTMLSelectElement>
      | React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target as typeof e.target & {
      value: string;
      name: string;
    };
    if (name === "publicationDate") {
      // setPostDetails({
      //   ...postDetails,
      //   [name]: new Date(value),
      // });
    } else {
      setPostDetails({
        ...postDetails,
        [name]: value,
        interestAreaId: interestAreaId
      });
    }
  };

  const {userData} = useAuth();
  const { mutate } = useCreatePost({});

  const handleSubmit = (event: React.FormEvent) => {
    const wikiTagIds = postDetails.wikiTags.map((tag) => tag.id);
    event.preventDefault();
    mutate({
      axiosInstance,
      ...postDetails,
      wikiTags: wikiTagIds,
      geoLocation: {
        latitude: locationDetails.latitude,
        longitude: locationDetails.longitude,
        address: locationDetails.address
      }
    });
  };

  return (
    <div className="d-flex">
      <div className="container mt-4 col-6">
        <h2 className="fw-bold">Create a New Spot!</h2>
        <PostCreateCard
            interestAreaTitle={interestAreaTitle}
            interestAreaId={interestAreaId}
          setPostDetails={setPostDetails}
          postDetails={postDetails}
          handleInputChange={handleInputChange}
          handleSubmit={handleSubmit}
          locationDetails={locationDetails}
          setLocationDetails={setLocationDetails}
          cardType={"create"}
        />
      </div>
      <div className="col-6 mt-5 ms-1">
        <h3>Preview</h3>
        <DetailedPostCardPreview  content={postDetails.content} enigmaUserId={userData.id.toString()}
                                  enigmaUserName={userData.name} enigmaUserUsername={userData.username}
                                  interestAreaId={interestAreaId.toString()} interestAreaTitle={interestAreaTitle}
                                  label={postDetails.label.toString()} sourceLink={postDetails.sourceLink} title={postDetails.title}/>
      </div>
    </div>
  );
};

export default CreatePost;
