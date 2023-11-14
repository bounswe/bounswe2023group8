import React, { useState } from "react";
import useCreatePost from "../../../hooks/usePost";
import { useAuth } from "../../../contexts/AuthContext";
import Tag from "../../Tag/Tag";

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
  const [locationModalOpen, setLocationModalOpen] = useState(false);

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
    } else if (name === "location") {
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

  const [newTag, setNewTag] = useState("");

  const addTag = () => {
    if (newTag && !postDetails.tags.includes(newTag)) {
      setPostDetails({
        ...postDetails,
        tags: [...postDetails.tags, newTag],
      });
      setNewTag("");
    }
  };

  const { mutate } = useCreatePost({});

  const handleSubmit = (event: React.FormEvent) => {
    event.preventDefault();
    mutate({
      axiosInstance,
      ...postDetails,
    });
  };

  return (
    <div className="d-flex">
      <div className="container mt-4 col-6">
        <h2 className="fw-bold">Create a New Post!</h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="interestArea" className="form-label text-nowrap">
              Interest Area:
            </label>
            <select
              id="interestArea"
              className="form-select bg-dark-subtle ms-5"
              name="interestArea"
              value={postDetails.interestArea}
              onChange={handleInputChange}
            >
              <option value="Furkanin Futbol Köşesi">
                Furkanın Futbol Köşesi
              </option>
            </select>
          </div>
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="title" className="form-label text-nowrap">
              Title:
            </label>
            <input
              id="title"
              type="text"
              className="form-control bg-dark-subtle ms-5"
              name="title"
              value={postDetails.title}
              onChange={handleInputChange}
            />
          </div>

          {/* Link */}
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="link" className="form-label text-nowrap">
              Link:
            </label>
            <input
              id="link"
              type="text"
              className="form-control bg-dark-subtle ms-5"
              name="link"
              value={postDetails.link}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3 d-flex flex-row align-items-start">
            <label htmlFor="description" className="form-label text-nowrap">
              Description/Comment:
            </label>
            <textarea
              id="description"
              className="form-control bg-dark-subtle ms-5"
              name="description"
              value={postDetails.description}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="tags" className="form-label text-nowrap">
              Tags:
            </label>
            <div
              className="d-flex flex-row align-items-center"
              style={{ gap: "0.5rem" }}
            >
              <div
                className="d-flex flex-wrap flex-grow-1"
                style={{ gap: "0.5rem" }}
              >
                {postDetails.tags.map((tag, index) => (
                  <div key={index} className="m-2">
                    <Tag className={""} name={tag} />
                  </div>
                ))}
              </div>
              <div className="d-flex align-items-center">
                {" "}
                {/* This div for input and button should stay on the right */}
                <input
                  type="text"
                  className="form-control bg-dark-subtle ms-5"
                  value={newTag}
                  onChange={(e) => setNewTag(e.target.value)}
                  onKeyPress={(e) => e.key === "Enter" && addTag()}
                  style={{ width: "150px" }} // Fixed width for input
                />
                <button
                  type="button"
                  className="btn btn-secondary"
                  onClick={addTag}
                  style={{ marginLeft: "0.5rem" }} // Add margin to separate from input
                >
                  +
                </button>
              </div>
            </div>
          </div>
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="label" className="form-label text-nowrap">
              Label:
            </label>
            <select
              id="label"
              className="form-select bg-dark-subtle ms-5"
              name="label"
              value={postDetails.label}
              onChange={handleInputChange}
            >
              <option value="News">News</option>
            </select>
          </div>
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="source" className="form-label text-nowrap">
              Source:
            </label>
            <input
              id="source"
              type="text"
              className="form-control bg-dark-subtle ms-5"
              name="source"
              value={postDetails.source}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3 d-flex flex-row align-items-center">
            <label htmlFor="publicationDate" className="form-label text-nowrap">
              Publication Date:
            </label>
            <input
              id="publicationDate"
              type="date"
              className="form-control bg-dark-subtle ms-5"
              name="publicationDate"
              value={postDetails.publicationDate.toISOString().substring(0, 10)}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3 d-flex flex-row align-items-center">
            <button
              className="btn btn-secondary"
              onClick={() => setLocationModalOpen(true)}
            >
              Add Location
            </button>
          </div>

          <div className="d-flex justify-content-center">
            <button type="submit" className="btn btn-primary">
              Create Post
            </button>
          </div>
        </form>
      </div>
      <div className="col-6 mt-5"></div>
    </div>
  );
};

export default CreatePost;
