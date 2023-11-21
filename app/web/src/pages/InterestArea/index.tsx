import React, { useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import InterestAreaCreateCard from "../../components/InterestArea/InterestAreaCreateCard";
import { useCreateInterestArea } from "../../hooks/useInterestArea";

const CreateInterestArea = () => {
  const { axiosInstance } = useAuth();
  type CreateInterestAreaFormData = {
    title: string;
    nestedInterestAreas: string[];
    wikiTags: string[];
    description: string;
    accessLevel: "public" | "private" | "personal";
  };

  const defaultInterestAreaDetails: CreateInterestAreaFormData = {
    title: "",
    nestedInterestAreas: [],
    wikiTags: [],
    description: "",
    accessLevel: "public",
  };

  const [interestAreaDetails, setInterestAreaDetails] = useState(
    defaultInterestAreaDetails
  );

  const handleInputChange = (
    e:
      | React.ChangeEvent<HTMLInputElement>
      | React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    if (name === "wikiTags" || name === "nestedInterestAreas") {
      const arrayValues = value
        .split(",")
        .map((item: string) => item.trim())
        .filter((item: string) => item !== "");
      setInterestAreaDetails({
        ...interestAreaDetails,
        [name]: arrayValues,
      });
    } else {
      setInterestAreaDetails({
        ...interestAreaDetails,
        [name]: value,
      });
    }
  };

  const { mutate } = useCreateInterestArea({});

  const handleSubmit = (event: React.FormEvent) => {
    event.preventDefault();
    mutate({
      axiosInstance,
      ...interestAreaDetails,
    });
  };

  return (
    <div className="d-flex">
      <div className="container mt-4 col-12">
        <h2 className="fw-bold">Create a New Interest Area!</h2>
        <InterestAreaCreateCard
          setInterestAreaDetails={setInterestAreaDetails}
          interestAreaDetails={interestAreaDetails}
          handleInputChange={handleInputChange}
          handleSubmit={handleSubmit}
          cardType={"create"}
        />
      </div>
      <div className="col-6 mt-5"></div>
    </div>
  );
};

export default CreateInterestArea;
