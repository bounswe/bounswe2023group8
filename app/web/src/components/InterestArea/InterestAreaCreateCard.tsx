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
    <Card className="">
      <CardBody className="">
        <form onSubmit={handleSubmit}>
          <div className="mb-3">
            <label htmlFor="accessLevel" className="form-label">
              Access Level:
            </label>
            <select
              id="accessLevel"
              className="form-select"
              value={interestAreaDetails.accessLevel}
              onChange={handleAccessLevelChange}
            >
              <option value={0}>Public</option>
              <option value={1}>Private</option>
              <option value={2}>Personal</option>
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
              value={interestAreaDetails.title}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="description" className="form-label">
              Description:
            </label>
            <textarea
              id="description"
              className="form-control"
              name="description"
              value={interestAreaDetails.description}
              onChange={handleInputChange}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="wikiTags" className="form-label">
              Tags:
            </label>
            <div className="d-flex flex-wrap">
              {interestAreaDetails.wikiTags.map((tag, index) => (
                <div
                  key={tag.id}
                  className="m-2"
                  style={{ cursor: "pointer" }}
                  onClick={() => removeTag(index)}
                >
                  <Tag className={""} name={tag.name} />
                </div>
              ))}
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

          <div className="mb-3">
            <label htmlFor="nestedInterestAreas" className="form-label">
              Sub-IAs:
            </label>
            <div className="d-flex flex-wrap">
              {interestAreaDetails.nestedInterestAreas.map((subIA, index) => (
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

              <div className="w-100 text-center mt-2">
                <input
                  type="text"
                  className="form-control"
                  value={newSubIA}
                  onChange={handleSubIAInputChange}
                  onFocus={() => setIsSubIAInputFocused(true)}
                  onBlur={handleSubIAInputBlur}
                />
                {isSubIAInputFocused &&
                  searchInterestAreasData &&
                  searchInterestAreasData.length > 0 && (
                    <div className="dropdown-menu show">
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
            <button type="submit" className="btn btn-primary">
              {cardType === "create"
                ? "Create Interest Area"
                : "Update Interest Area"}
            </button>
          </div>
        </form>
      </CardBody>
    </Card>
  );
};

export default InterestAreaCreateCard;
