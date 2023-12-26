import React, { useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import InterestAreaCreateCard, {
  CreateInterestAreaFormData,
} from "../../components/InterestArea/InterestAreaCreateCard";
import { useCreateInterestArea } from "../../hooks/useInterestArea";

const CreateInterestArea = () => {
  const { axiosInstance } = useAuth();

  const defaultInterestAreaDetails: CreateInterestAreaFormData = {
    title: "",
    nestedInterestAreas: [],
    wikiTags: [],
    description: "",
    accessLevel: 0,
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
  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    const wikiTagIds = interestAreaDetails.wikiTags.map((tag) => tag.id);
    const nestedInterestAreaIds = interestAreaDetails.nestedInterestAreas.map(
      (subIA) => subIA.id
    );
    const dataToSend = {
      ...interestAreaDetails,
      wikiTags: wikiTagIds,
      nestedInterestAreas: nestedInterestAreaIds,
    };
    mutate({
      axiosInstance,
      ...dataToSend,
    });
  };

  return (
    <div className="container">
      <InterestAreaCreateCard
        setInterestAreaDetails={setInterestAreaDetails}
        interestAreaDetails={interestAreaDetails}
        handleInputChange={handleInputChange}
        handleSubmit={handleSubmit}
        cardType={"create"}
      />
    </div>
  );
};

export default CreateInterestArea;
