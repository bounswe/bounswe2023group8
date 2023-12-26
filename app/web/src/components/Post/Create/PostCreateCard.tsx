import React, {ChangeEvent, useEffect, useState} from "react";
import Tag from "../../Tag/Tag";
import LocationPicker, {
  SelectedLocationFormData,
} from "../../Geolocation/LocationPicker";
import { Card, CardBody } from "react-bootstrap";
import { useSearchWikitags } from "../../../hooks/useWikiTags";
import { useAuth } from "../../../contexts/AuthContext";

export type CreatePostFormData = {
  interestAreaId: number;
  title: string;
  content: string;
  wikiTags: { id: string; name: string }[];
  label: number;
  sourceLink: string;
  isAgeRestricted: boolean;
};

export type CreatePostRequestData = {
  interestAreaId: number;
  title: string;
  content: string;
  wikiTags: string[];
  label: number;
  sourceLink: string;
  isAgeRestricted: boolean;
};

export type PostCreateCardProps = {
  interestAreaId: number
  interestAreaTitle: string,
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
    interestAreaId,
    interestAreaTitle,
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
  const [selectedOption, setSelectedOption] = useState("false");

  const handleOptionChange = (event: ChangeEvent<HTMLInputElement>) => {
    setSelectedOption(event.target.value)
    setPostDetails({
      ...postDetails,
      isAgeRestricted: event.target.value == "true"
    })
  };

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
              Bunch:
            </label>
            <select
              id="interestArea"
              className="form-select"
              name="interestArea"
              value={interestAreaId}
              onChange={handleInputChange}
            >
              <option value={postDetails.interestAreaId}>
                {interestAreaTitle}
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
              required
            />
          </div>
          <div className="mb-3">
            <label htmlFor="sourceLink" className="form-label ">
              Link:
            </label>
            <input
                id="sourceLink"
                type="text"
                className="form-control"
                name="sourceLink"
                value={postDetails.sourceLink}
                onChange={handleInputChange}
                required
            />
          </div>
          <div className="mb-3">
            <label htmlFor="content" className="form-label ">
              Description/Comment:
            </label>
            <textarea
              id="content"
              className="form-control"
              name="content"
              value={postDetails.content}
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
                  <Tag className={""} label={tag.name} />
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
              <option value={4}>Discussion</option>
              <option value={0}>Documentation</option>
              <option value={1}>Learning</option>
              <option value={2}>News</option>
              <option value={3}>Research</option>
            </select>
          </div>
          <div className="mb-3">
            <label className="mx-2">
              Restrict for ages below 18:
            </label>
            <label className="mx-2">
              <input
                  className="mx-1"
                  type="radio"
                  name="options"
                  value="false"
                  checked={selectedOption === 'false'}
                  onChange={handleOptionChange}
              />
              Do not restrict
            </label>
            <label className="mx-2">
              <input
                  className="mx-1"
                  type="radio"
                  name="options"
                  value="true"
                  checked={selectedOption === 'true'}
                  onChange={handleOptionChange}
              />
              Restrict
            </label>
          </div>
          <div className="mb-3 d-flex">
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
            <button type="submit" className="btn btn-primary WA-theme-bg-main WA-theme-light">
              {cardType == "create" && "Create Spot"}
              {cardType == "update" && "Update Spot"}
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