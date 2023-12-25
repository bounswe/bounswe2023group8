import React, { useEffect, useState } from "react";
import { Card, CardBody } from "react-bootstrap";
import Tag from "../Tag/Tag";
import { useSearchWikitags } from "../../hooks/useWikiTags";
import { useAuth } from "../../contexts/AuthContext";
import { useSearchInterestArea } from "../../hooks/useInterestArea";

export type CreateInterestAreaFormData = {
  title: string;
  description: string;
  wikiTags: { id: string; name: string }[];
  nestedInterestAreas: { id: string; title: string }[];
  accessLevel: 0 | 1 | 2;
};

export type InterestAreaRequestData = {
  title: string;
  description: string;
  wikiTags: string[];
  nestedInterestAreas: string[];
  accessLevel: 0 | 1 | 2;
};

export type InterestAreaCreateCardProps = {
  handleSubmit: (_: React.FormEvent) => void;
  interestAreaDetails: CreateInterestAreaFormData;
  setInterestAreaDetails: React.Dispatch<
    React.SetStateAction<CreateInterestAreaFormData>
  >;
  handleInputChange: (
    e:
      | React.ChangeEvent<HTMLInputElement>
      | React.ChangeEvent<HTMLTextAreaElement>
  ) => void;
  cardType: "create" | "update";
};

const InterestAreaCreateCard = ({
  handleInputChange,
  handleSubmit,
  interestAreaDetails,
  setInterestAreaDetails,
  cardType,
}: InterestAreaCreateCardProps) => {
  const [newTag, setNewTag] = useState("");
  const [newSubIA, setNewSubIA] = useState("");
  const [tagSearchTerm, setTagSearchTerm] = useState("");
  const [debouncedTagSearchTerm, setDebouncedTagSearchTerm] = useState("");
  const [subIASearchTerm, setSubIASearchTerm] = useState("");
  const [debouncedSubIASearchTerm, setDebouncedSubIASearchTerm] = useState("");
  const [isSubIAInputFocused, setIsSubIAInputFocused] = useState(false);
  const [isTagInputFocused, setIsTagInputFocused] = useState(false);

  const handleTagInputBlur = () => {
    setTimeout(() => {
      setIsTagInputFocused(false);
    }, 150);
  };

  const handleSubIAInputBlur = () => {
    setTimeout(() => {
      setIsSubIAInputFocused(false);
    }, 150);
  };

  const { mutate: searchInterestAreas, data: searchInterestAreasData } =
    useSearchInterestArea({});

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
    const timerId = setTimeout(() => {
      setDebouncedSubIASearchTerm(subIASearchTerm);
    }, 500);

    return () => {
      clearTimeout(timerId);
    };
  }, [subIASearchTerm]);

  useEffect(() => {
    if (debouncedTagSearchTerm) {
      searchWikiTags({
        searchKey: debouncedTagSearchTerm,
        axiosInstance: axiosInstance,
      });
    }
  }, [debouncedTagSearchTerm]);

  useEffect(() => {
    if (debouncedSubIASearchTerm) {
      searchInterestAreas({
        searchKey: debouncedSubIASearchTerm,
        axiosInstance: axiosInstance,
      });
    }
  }, [debouncedSubIASearchTerm]);

  const handleAccessLevelChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const numericValue = parseInt(e.target.value, 10);
    setInterestAreaDetails({
      ...interestAreaDetails,
      accessLevel: numericValue as CreateInterestAreaFormData["accessLevel"],
    });
  };

  const addSubIA = (id: string, title: string) => {
    const newSubIA = { id, title };
    if (
      !interestAreaDetails.nestedInterestAreas.some((subIA) => subIA.id === id)
    ) {
      setInterestAreaDetails({
        ...interestAreaDetails,
        nestedInterestAreas: [
          ...interestAreaDetails.nestedInterestAreas,
          newSubIA,
        ],
      });
    }
  };

  const removeSubIA = (indexToRemove: number) => {
    setInterestAreaDetails({
      ...interestAreaDetails,
      nestedInterestAreas: interestAreaDetails.nestedInterestAreas.filter(
        (_, index) => index !== indexToRemove
      ),
    });
  };

  const onSubIASelect = (id: string, name: string) => {
    addSubIA(id, name);
  };

  const handleSubIAInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNewSubIA(e.target.value);
    setSubIASearchTerm(e.target.value);
  };

  const onTagSelect = (id: string, name: string) => {
    addTag(id, name);
  };

  const handleTagInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setNewTag(e.target.value);
    setTagSearchTerm(e.target.value);
  };

  const addTag = (id: string, name: string) => {
    const newTag = { id, name };
    if (!interestAreaDetails.wikiTags.some((tag) => tag.id === id)) {
      setInterestAreaDetails({
        ...interestAreaDetails,
        wikiTags: [...interestAreaDetails.wikiTags, newTag],
      });
    }
  };

  const removeTag = (indexToRemove: number) => {
    setInterestAreaDetails({
      ...interestAreaDetails,
      wikiTags: interestAreaDetails.wikiTags.filter(
        (_, index) => index !== indexToRemove
      ),
    });
  };

  return (
    <>
      <div
        className="WA-theme-bg-dark"
        style={{
          borderBottomLeftRadius: "20px",
          borderBottomRightRadius: "20px",
        }}
      >
        <h2 className="fw-bold mx-3 mb-3 p-3 text-white text-center">
          {cardType === "create" ? "Create a new Bunch" : "Update Bunch"}
        </h2>
      </div>
      <div className="d-flex justify-content-between">
        <div className="WA-theme-bg-regular p-3 w-100 rounded-3">
          <label htmlFor="title" className="form-label h4">
            Bunch Name:
          </label>
          <input
            id="title"
            type="text"
            className="form-control WA-theme-bg-soft"
            name="title"
            value={interestAreaDetails.title}
            onChange={handleInputChange}
          />
        </div>
        <div className="WA-theme-bg-regular p-3 ms-3 w-100 rounded-3">
          <label htmlFor="accessLevel" className="form-label h4">
            Access Level:
          </label>
          <select
            id="accessLevel"
            className="form-select WA-theme-bg-soft"
            value={interestAreaDetails.accessLevel}
            onChange={handleAccessLevelChange}
          >
            <option value={0}>Public</option>
            <option value={1}>Private</option>
            <option value={2}>Personal</option>
          </select>
        </div>
      </div>
      <div className="my-3 WA-theme-bg-regular p-3 w-100 rounded-3">
        <label htmlFor="description" className="form-label h4">
          Description:
        </label>
        <textarea
          id="description"
          className="form-control WA-theme-bg-soft"
          name="description"
          value={interestAreaDetails.description}
          onChange={handleInputChange}
        />
      </div>
      <div className="WA-theme-bg-regular p-3 w-100 rounded-3">
        <label htmlFor="wikiTags" className="form-label h4">
          Tags:
        </label>
        <div className="d-flex flex-wrap">
          {interestAreaDetails.wikiTags &&
            interestAreaDetails.wikiTags.map((tag, index) => (
              <div
                key={tag.id}
                className="m-2"
                style={{ cursor: "pointer" }}
                onClick={() => removeTag(index)}
              >
                <Tag className={""} label={tag.name} />
              </div>
            ))}
          <div className="w-100 text-center d-flex justify-content-center align-items-center">
            <img
              className="mx-2"
              src="/assets/theme/icons/SearchState=Active.png"
              style={{ width: "20px", height: "20px" }}
            />
            <input
              type="text"
              className="form-control WA-theme-bg-soft"
              value={newTag}
              onChange={handleTagInputChange}
              onFocus={() => setIsTagInputFocused(true)}
              onBlur={handleTagInputBlur}
            />
            {isTagInputFocused &&
              searchWikiTagsData &&
              searchWikiTagsData.length > 0 && (
                <div className="dropdown-menu show">
                  {searchWikiTagsData.map((result: any) => (
                    <button
                      key={result.id}
                      className="dropdown-item"
                      type="button"
                      onClick={() =>
                        onTagSelect(result.id, result.display.label.value)
                      }
                    >
                      {result.display.label.value} - {result.description}
                    </button>
                  ))}
                </div>
              )}
          </div>
        </div>
      </div>

      <div className="WA-theme-bg-regular p-3 w-100 mt-3 rounded-3">
        <label htmlFor="nestedInterestAreas" className="form-label h4">
          Sub-Bunches:
        </label>
        <div className="d-flex flex-wrap">
          {interestAreaDetails.nestedInterestAreas &&
            interestAreaDetails.nestedInterestAreas.map((subIA, index) => (
              <div
                key={subIA.id}
                className="d-flex justify-content-between align-items-center bg-light px-2 py-1 m-2 rounded shadow-sm"
                onClick={() => removeSubIA(index)}
              >
                <button
                  type="button"
                  className="btn-close"
                  aria-label="Close"
                  onClick={(e) => {
                    e.stopPropagation();
                    removeSubIA(index);
                  }}
                ></button>
                <span>{subIA.title}</span>
              </div>
            ))}

          <div className="w-100 text-center d-flex justify-content-center align-items-center">
            <img
              className="mx-2"
              src="/assets/theme/icons/SearchState=Active.png"
              style={{ width: "20px", height: "20px" }}
            />
            <input
              type="text"
              className="form-control WA-theme-bg-soft"
              value={newSubIA}
              onChange={handleSubIAInputChange}
              onFocus={() => setIsSubIAInputFocused(true)}
              onBlur={handleSubIAInputBlur}
            />
            {isSubIAInputFocused &&
              searchInterestAreasData &&
              searchInterestAreasData.length > 0 && (
                <div
                  className="dropdown-menu show"
                  style={{
                    maxHeight: "300px",
                    maxWidth: "75vw",
                    overflowY: "scroll",
                  }}
                >
                  {searchInterestAreasData.map((result: any) => (
                    <button
                      key={result.id}
                      className="dropdown-item"
                      type="button"
                      onClick={() => onSubIASelect(result.id, result.title)}
                    >
                      {result.title} - {result.description}
                    </button>
                  ))}
                </div>
              )}
          </div>
        </div>
      </div>

      <div className="d-flex justify-content-center mt-4">
        <button
          type="submit"
          className="btn btn-primary rounded-4"
          onClick={handleSubmit}
        >
          {cardType === "create" ? "Create Bunch" : "Update Bunch"}
        </button>
      </div>
    </>
  );
};

export default InterestAreaCreateCard;
