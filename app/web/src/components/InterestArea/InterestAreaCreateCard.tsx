import React, { useState } from "react";
import { Card, CardBody } from "react-bootstrap";
import Tag from "../Tag/Tag";

export type CreateInterestAreaFormData = {
  title: string;
  description: string;
  wikiTags: string[];
  nestedInterestAreas: string[];
  accessLevel: "public" | "private" | "personal";
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

  const handleAccessLevelChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const { value } = e.target;
    setInterestAreaDetails({
      ...interestAreaDetails,
      accessLevel: value as CreateInterestAreaFormData["accessLevel"],
    });
  };

  const addSubIA = () => {
    if (
      newSubIA &&
      !interestAreaDetails.nestedInterestAreas.includes(newSubIA)
    ) {
      setInterestAreaDetails({
        ...interestAreaDetails,
        nestedInterestAreas: [
          ...interestAreaDetails.nestedInterestAreas,
          newSubIA,
        ],
      });
      setNewSubIA("");
    }
  };

  const handleKeyPress = (event: React.KeyboardEvent, action: () => void) => {
    if (event.key === "Enter") {
      event.preventDefault();
      action();
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

  const addTag = () => {
    if (newTag && !interestAreaDetails.wikiTags.includes(newTag)) {
      setInterestAreaDetails({
        ...interestAreaDetails,
        wikiTags: [...interestAreaDetails.wikiTags, newTag],
      });
      setNewTag("");
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
              <option value="public">Public</option>
              <option value="private">Private</option>
              <option value="personal">Personal</option>
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
                  key={index}
                  className="m-2"
                  style={{ cursor: "pointer" }}
                  onClick={() => removeTag(index)}
                >
                  <Tag className={""} name={tag} />
                </div>
              ))}
              <div className="w-100 text-center">
                <input
                  type="text"
                  className="form-control"
                  value={newTag}
                  onChange={(e) => setNewTag(e.target.value)}
                  onKeyPress={(e) => handleKeyPress(e, addTag)}
                />
                <button
                  type="button"
                  className="btn btn-ternary border mt-2"
                  onClick={addTag}
                >
                  Add Tag
                </button>
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
                  key={subIA}
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
                  <span>{subIA}</span>
                </div>
              ))}

              <div className="w-100 text-center mt-2">
                <input
                  type="text"
                  className="form-control"
                  value={newSubIA}
                  onChange={(e) => setNewSubIA(e.target.value)}
                  onKeyPress={(e) => handleKeyPress(e, addSubIA)}
                />
                <button
                  type="button"
                  className="btn btn-ternary border mt-2"
                  onClick={addSubIA}
                >
                  Add Sub IA
                </button>
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
