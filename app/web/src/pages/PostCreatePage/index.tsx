import React, { useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import PostCreateCard, {CreatePostFormData} from "../../components/Post/Create/PostCreateCard";
import {SelectedLocationFormData} from "../../components/Geolocation/LocationPicker";
import {useCreatePost} from "../../hooks/usePost";



const CreatePost = () => {
  const { axiosInstance } = useAuth();
  const defaultPostDetails: CreatePostFormData = {
    interestArea: "",
    title: "",
    link: "",
    description: "",
    tags: [],
    label: "",
    source: "",
    publicationDate: new Date(),
  };

  const defaultLocationDetails: SelectedLocationFormData = {
    latitude: 41,
    longitude: 29,
    address: "",
    locationSelected: false
  }

  const [postDetails, setPostDetails] = useState(defaultPostDetails);
  const [locationDetails, setLocationDetails] = useState(defaultLocationDetails);

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
    if (name === "tags") {
      const tagsArray = value.split(" ").filter((tag: string) => tag !== "");
      setPostDetails({
        ...postDetails,
        [name]: tagsArray,
      });
    } else if (name === "publicationDate") {
      setPostDetails({
        ...postDetails,
        [name]: new Date(value),
      });
    } else {
      setPostDetails({
        ...postDetails,
        [name]: value,
      });
    }
  };

  const { mutate } = useCreatePost({});

  const handleSubmit = (event: React.FormEvent) => {
    event.preventDefault();
    mutate({
      axiosInstance,
      ...postDetails,
      ...locationDetails,
    });
  };

  return (
    <div className="d-flex">
      <div className="container mt-4 col-6">
        <h2 className="fw-bold">Create a New Post!</h2>
        <PostCreateCard setPostDetails={setPostDetails} postDetails={postDetails}
                        handleInputChange={handleInputChange} handleSubmit={handleSubmit}
                        locationDetails={locationDetails} setLocationDetails={setLocationDetails}
                        cardType={"create"}/>
      </div>
      <div className="col-6 mt-5"></div>
    </div>
  );
};

export default CreatePost;
