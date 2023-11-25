import React, { useEffect, useState } from "react";
import Tag from "../../Tag/Tag";
import LocationPicker, {
  SelectedLocationFormData,
} from "../../Geolocation/LocationPicker";
import { Card, CardBody } from "react-bootstrap";
import { useSearchWikitags } from "../../../hooks/useWikiTags";
import { useAuth } from "../../../contexts/AuthContext";

export type CreatePostFormData = {
  interestArea: string;
  title: string;
  link: string;
  description: string;
  wikiTags: { id: string; name: string }[];
  label: string;
  source: string;
  publicationDate: Date;
};

export type CreatePostRequestData = {
  interestArea: string;
  title: string;
  link: string;
  description: string;
  wikiTags: string[];
  label: string;
  source: string;
  publicationDate: Date;
};

export type PostCreateCardProps = {
  handleSubmit: (_: React.FormEvent) => void;
  postDetails: CreatePostFormData;
  setPostDetails: React.Dispatch<React.SetStateAction<CreatePostFormData>>;
  handleInputChange: (
    e:
      | React.ChangeEvent<HTMLInputElement>
      | React.ChangeEvent<HTMLSelectElement>
      | React.ChangeEvent<HTMLTextAreaElement>
  ) => void;
  locationDetails: SelectedLocationFormData;
  setLocationDetails: React.Dispatch<
    React.SetStateAction<SelectedLocationFormData>
  >;
  cardType: "create" | "update";
};
const PostCreateCard = ({
  handleInputChange,
  handleSubmit,
  postDetails,
  setPostDetails,
  locationDetails,
  setLocationDetails,
  cardType,
}: PostCreateCardProps) => {
  const defaultLocationDetails: SelectedLocationFormData = {
    latitude: 41,
    longitude: 29,
    address: "",
    locationSelected: false,
  };
  const [showLocationPickerModal, setShowLocationPickerModal] = useState(false);
  const [newTag, setNewTag] = useState("");
  const [tagSearchTerm, setTagSearchTerm] = useState("");
  const [debouncedTagSearchTerm, setDebouncedTagSearchTerm] = useState("");
  const [isTagInputFocused, setIsTagInputFocused] = useState(false);

  const onTagSelect = (id: string, name: string) => {
    addTag(id, name);
  };

  const handleTagInputBlur = () => {
    setTimeout(() => {
      setIsTagInputFocused(false);
    }, 150);
  };

  const handleTagInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNewTag(e.target.value);
    setTagSearchTerm(e.target.value);
  };

  const addTag = (id: string, name: string) => {
    const newTag = { id, name };
    if (!postDetails.wikiTags.some((tag) => tag.id === id)) {
      setPostDetails({
        ...postDetails,
        wikiTags: [...postDetails.wikiTags, newTag],
      });
    }
  };

  const removeTag = (indexToRemove: number) => {
    setPostDetails({
      ...postDetails,
      wikiTags: postDetails.wikiTags.filter(
        (_, index) => index != indexToRemove
      ),
    });
  };

  const { mutate: searchWikiTags, data: searchWikiTagsData } =
    useSearchWikitags({});

  const { axiosInstance } = useAuth();
  useEffect(() => {
    const timerId = setTimeout(() => {
      setDebouncedTagSearchTerm(tagSearchTerm);
    }, 500);

    return () => {
      clearTimeout(timerId);
    };
  }, [tagSearchTerm]);

  useEffect(() => {
    if (debouncedTagSearchTerm) {
      searchWikiTags({
        searchKey: debouncedTagSearchTerm,
        axiosInstance: axiosInstance,
      });
    }
  }, [debouncedTagSearchTerm]);

  return (
    <Card className="">
      <CardBody className="">
        <form onSubmit={handleSubmit}>
          <div className="mb-3">
            <label htmlFor="interestArea" className="form-label">
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
                Furkanın Futbol Köşesi
              </option>
            </select>
          </div>
          <div className="mb-3">
            <label htmlFor="title" className="form-label">
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
          <div className="mb-3">
            <label htmlFor="link" className="form-label">
              Link:
            </label>
            <input
              id="link"
              type="text"
              className="form-control"
              name="link"
              value={postDetails.link}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="description" className="form-label ">
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
          <div className="mb-3">
            <label htmlFor="wikiTags" className="form-label ">
              Tags:
            </label>
            <div className="d-flex flex-wrap">
              {postDetails.wikiTags.map((tag, index) => (
                <div
                  key={tag.id}
                  className="m-2"
                  style={{ cursor: "pointer" }}
                  onClick={() => removeTag(index)}
                >
                  <Tag className={""} name={tag.name} />
                </div>
              ))}
            </div>
            <div className="w-100 text-center">
              <input
                type="text"
                className="form-control"
                value={newTag}
                onChange={handleTagInputChange}
                onFocus={() => setIsTagInputFocused(true)}
                onBlur={handleTagInputBlur}
              />
              {isTagInputFocused &&
                searchWikiTagsData &&
                searchWikiTagsData.length > 0 && (
                  <div className="dropdown-menu show">
                    {searchWikiTagsData.map((tag: any) => (
                      <div
                        key={tag.id}
                        className="dropdown-item"
                        onClick={() =>
                          onTagSelect(tag.id, tag.display.label.value)
                        }
                      >
                        {tag.display.label.value} - {tag.description}
                      </div>
                    ))}
                  </div>
                )}
            </div>
          </div>
          <div className="mb-3">
            <label htmlFor="label" className="form-label ">
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
            </select>
          </div>
          <div className="mb-3">
            <label htmlFor="source" className="form-label ">
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
          <div className="mb-3">
            <label htmlFor="publicationDate" className="form-label ">
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
          <div className="mb-3">
            <button
              className="btn btn-secondary"
              type="button"
              onClick={() =>
                setShowLocationPickerModal(!showLocationPickerModal)
              }
            >
              {locationDetails.locationSelected
                ? "Change Location"
                : "Add Location"}
            </button>
            <span className="px-2"> {locationDetails.address} </span>
            {locationDetails.locationSelected && (
              <button
                className="btn btn-secondary"
                type="button"
                onClick={() => {
                  setLocationDetails(defaultLocationDetails);
                }}
              >
                Delete Location
              </button>
            )}
          </div>

          <div className="d-flex justify-content-center">
            <button type="submit" className="btn btn-primary">
              {cardType == "create" && "Create Post"}
              {cardType == "update" && "Update Post"}
            </button>
          </div>
        </form>
        <LocationPicker
          showLocationPickerModal={showLocationPickerModal}
          setShowLocationPickerModal={setShowLocationPickerModal}
          locationFormData={locationDetails}
          setLocationFormData={setLocationDetails}
        />
      </CardBody>
    </Card>
  );
};

export default PostCreateCard;
