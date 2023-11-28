import React, { useEffect, useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import PostCreateCard, {
  CreatePostFormData,
} from "../../components/Post/Create/PostCreateCard";
import { SelectedLocationFormData } from "../../components/Geolocation/LocationPicker";
import { useParams } from "react-router-dom";
import { useGetPost, useUpdatePost } from "../../hooks/usePost";

const PostUpdatePage = () => {
  const { axiosInstance } = useAuth();
  const params = useParams();
  const defaultPostDetails: CreatePostFormData = {
    interestAreaId: -1,
    title: "",
    content: "",
    wikiTags: [],
    label: 1,
    sourceLink: "",
  };

  const defaultLocationDetails: SelectedLocationFormData = {
    latitude: 41,
    longitude: 29,
    address: "",
    locationSelected: false,
  };

  const [postDetails, setPostDetails] = useState(defaultPostDetails);
  const [locationDetails, setLocationDetails] = useState(
    defaultLocationDetails
  );

  const mutateUpdatePost = useUpdatePost({}).mutate;
  const mutateGetPost = useGetPost({}).mutate;

  useEffect(() => {
    const getData = async () => {
      const data = mutateGetPost({
        axiosInstance: axiosInstance,
        id: params.postId || "",
      });
      console.log(params.postId);
      console.log(data);

      const defaultPostDetails: CreatePostFormData = {
        interestAreaId: -1,
        title: "Derbi Heyecanı",
        content: " Galatasaray vs. Fenerbahçe",
        wikiTags: [],
        label: 1,
        sourceLink: "asdasd",
      };
      const defaultLocationDetails: SelectedLocationFormData = {
        latitude: 40.987673250682725,
        longitude: 29.03688669204712,
        address: "Kadıköy/İstanbul, Türkiye",
        locationSelected: true,
      };
      const mockData = { ...defaultPostDetails, ...defaultLocationDetails };

      setPostDetails(mockData);
      setLocationDetails(mockData);
    };

    getData();
  }, []);
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
      });
    }
  };

  const handleSubmit = (event: React.FormEvent) => {
    const wikiTagIds = postDetails.wikiTags.map((tag) => tag.id);
    event.preventDefault();
    mutateUpdatePost({
      axiosInstance,
      ...postDetails,
      wikiTags: wikiTagIds,
      geoLocation: {
        latitude: locationDetails.latitude,
        longitude: locationDetails.longitude,
        address: locationDetails.address,
      }
    });
  };

  return (
    <div className="d-flex">
      <div className="container mt-4 col-6">
        <h2 className="fw-bold">Update Post</h2>
        <PostCreateCard
            interestAreaId={1}
            interestAreaTitle={"asdasd"}
          setPostDetails={setPostDetails}
          postDetails={postDetails}
          handleInputChange={handleInputChange}
          handleSubmit={handleSubmit}
          locationDetails={locationDetails}
          setLocationDetails={setLocationDetails}
          cardType={"update"}
        />
      </div>
      <div className="col-6 mt-5"></div>
    </div>
  );
};

export default PostUpdatePage;
