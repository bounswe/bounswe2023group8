import React, { useState } from "react";
import useCreatePost from "../../../hooks/usePost";
import { useAuth } from "../../../contexts/AuthContext";

export type CreatePostFormData = {
  interestArea: string;
  title: string;
  link: string;
  description: string;
  tags: string[];
  label: string;
  source: string;
  publicationDate: Date;
  location: string[];
};

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
    location: [],
  };

  const [postDetails, setPostDetails] = useState(defaultPostDetails);

  const handleInputChange = (e: any) => {
    const { name, value } = e.target;
    if (name === "tags") {
      // Assuming tags are space separated
      const tagsArray = value.split(" ").filter((tag: string) => tag !== ""); // Filter out any empty strings
      setPostDetails({
        ...postDetails,
        [name]: tagsArray,
      });
    } else if (name === "publicationDate") {
      setPostDetails({
        ...postDetails,
        [name]: new Date(value),
      });
    } else if (name === "location") {
      // Assuming location is a single string, you'll need to adjust this if it's not
      setPostDetails({
        ...postDetails,
        [name]: [value],
      });
    } else {
      setPostDetails({
        ...postDetails,
        [name]: value,
      });
    }
  };

  const { mutate } = useCreatePost({});

  const handleSubmit = (e: any) => {
    e.preventDefault();
    mutate({
      axiosInstance,
      ...postDetails,
    });
  };

  return (
    <div className="container mt-4">
      <h2>Create a New Post!</h2>
      <form onSubmit={handleSubmit}>
        {/* Interest Area */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="interestArea" className="form-label me-2">
            Interest Area:
          </label>
          <select
            id="interestArea"
            className="form-select"
            name="interestArea"
            value={postDetails.interestArea}
            onChange={handleInputChange}
          >
            <option value="Furkanin Futbol Köşesi">
              Furkanin Futbol Köşesi
            </option>
            {/* Add other options here */}
          </select>
        </div>

        {/* Title */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="title" className="form-label me-2">
            Title:
          </label>
          <input
            id="title"
            type="text"
            className="form-control"
            name="title"
            value={postDetails.title}
            onChange={handleInputChange}
          />
        </div>

        {/* Link */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="link" className="form-label me-2">
            Link:
          </label>
          <input
            id="link"
            type="url"
            className="form-control"
            name="link"
            value={postDetails.link}
            onChange={handleInputChange}
          />
        </div>

        {/* Description/Comment */}
        <div className="mb-3 d-flex flex-row align-items-start">
          <label htmlFor="description" className="form-label me-2">
            Description/Comment:
          </label>
          <textarea
            id="description"
            className="form-control"
            name="description"
            value={postDetails.description}
            onChange={handleInputChange}
          />
        </div>

        {/* Tags */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="tags" className="form-label me-2">
            Tags:
          </label>
          <input
            id="tags"
            type="text"
            className="form-control"
            name="tags"
            value={postDetails.tags.join(" ")}
            onChange={handleInputChange}
          />
        </div>

        {/* Label */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="label" className="form-label me-2">
            Label:
          </label>
          <select
            id="label"
            className="form-select"
            name="label"
            value={postDetails.label}
            onChange={handleInputChange}
          >
            <option value="News">News</option>
            {/* Add other options here */}
          </select>
        </div>

        {/* Source */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="source" className="form-label me-2">
            Source:
          </label>
          <input
            id="source"
            type="text"
            className="form-control"
            name="source"
            value={postDetails.source}
            onChange={handleInputChange}
          />
        </div>

        {/* Publication Date */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="publicationDate" className="form-label me-2">
            Publication Date:
          </label>
          <input
            id="publicationDate"
            type="date"
            className="form-control"
            name="publicationDate"
            value={postDetails.publicationDate.toISOString().substring(0, 10)}
            onChange={handleInputChange}
          />
        </div>

        {/* Location */}
        <div className="mb-3 d-flex flex-row align-items-center">
          <label htmlFor="location" className="form-label me-2">
            Location:
          </label>
          <input
            id="location"
            type="text"
            className="form-control"
            name="location"
            value={postDetails.location.join(", ")}
            onChange={handleInputChange}
          />
        </div>

        <button type="submit" className="btn btn-primary">
          Create Post
        </button>
      </form>
    </div>
  );
};

export default CreatePost;
