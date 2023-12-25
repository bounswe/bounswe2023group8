import React, { useEffect, useState } from "react";
import { useAuth } from "../../contexts/AuthContext";
import InterestAreaCreateCard, {
  CreateInterestAreaFormData,
} from "../../components/InterestArea/InterestAreaCreateCard";
import { useParams } from "react-router-dom";
import {
  useGetInterestArea,
  useGetSubInterestAreasOfInterestArea,
  useUpdateInterestArea,
} from "../../hooks/useInterestArea";

export type AccessLevel = "PUBLIC" | "PRIVATE" | "PERSONAL";

export const accessLevelMapping: { [key in AccessLevel]: 0 | 1 | 2 } = {
  PUBLIC: 0,
  PRIVATE: 1,
  PERSONAL: 2,
};

const UpdateInterestArea = () => {
  const { axiosInstance } = useAuth();
  const params = useParams();
  const { interestAreaId } = params;

  const { mutate } = useUpdateInterestArea({
    axiosInstance,
    interestAreaId: parseInt(interestAreaId as string),
  });

  const { isSuccess } = useGetInterestArea({
    axiosInstance,
    interestAreaId: parseInt(interestAreaId as string),
    config: {
      onSuccess: (data: any) => {
        const newDetails = {
          title: data.title,
          wikiTags: data.wikiTags.map((tag: any) => ({
            id: tag.id,
            name: tag.label,
          })),
          description: data.description,
          accessLevel: accessLevelMapping[data.accessLevel as AccessLevel],
        };
        setGetInterestAreaData(newDetails);
      },
    },
  });

  const { isSuccess: isNestedInterestAreasSuccess } =
    useGetSubInterestAreasOfInterestArea({
      axiosInstance,
      interestAreaId: parseInt(interestAreaId as string),
      config: {
        onSuccess: (data: any) => {
          const newDetails = {
            nestedInterestAreas: data.map((result: any) => ({
              title: result.title,
              id: result.id,
            })),
          };
          setGetSubInterestAreasData(newDetails);
        },
      },
    });

  const [initialInterestAreaDetails, setInitialInterestAreaDetails] =
    useState<CreateInterestAreaFormData>({
      title: "",
      nestedInterestAreas: [],
      wikiTags: [],
      description: "",
      accessLevel: 0,
    });

  const [getInterestAreaData, setGetInterestAreaData] = useState<any>(null);
  const [getSubInterestAreasData, setGetSubInterestAreasData] =
    useState<any>(null);

  useEffect(() => {
    if (isSuccess && isNestedInterestAreasSuccess) {
      setInitialInterestAreaDetails({
        ...getInterestAreaData,
        ...getSubInterestAreasData,
      });
    }
  }, [isSuccess, isNestedInterestAreasSuccess]);

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
      setInitialInterestAreaDetails({
        ...initialInterestAreaDetails,
        [name]: arrayValues,
      });
    } else {
      setInitialInterestAreaDetails({
        ...initialInterestAreaDetails,
        [name]: value,
      });
    }
  };

  const handleSubmit = (event: React.FormEvent) => {
    event.preventDefault();
    const wikiTagIds = initialInterestAreaDetails.wikiTags.map((tag) => tag.id);
    const nestedInterestAreaIds =
      initialInterestAreaDetails.nestedInterestAreas.map((subIA) => subIA.id);
    const dataToSend = {
      ...initialInterestAreaDetails,
      wikiTags: wikiTagIds,
      nestedInterestAreas: nestedInterestAreaIds,
    };
    mutate({
      axiosInstance,
      interestAreaId: parseInt(interestAreaId as string),
      ...dataToSend,
    });
  };

  return (
    <>
      {isSuccess && isNestedInterestAreasSuccess && (
        <div className="d-flex">
          <div className="container mt-4 col-12">
            <h2 className="fw-bold">Update the Bunch!</h2>
            <InterestAreaCreateCard
              setInterestAreaDetails={setInitialInterestAreaDetails}
              interestAreaDetails={initialInterestAreaDetails}
              handleInputChange={handleInputChange}
              handleSubmit={handleSubmit}
              cardType={"update"}
            />
          </div>
          <div className="col-6 mt-5"></div>
        </div>
      )}
    </>
  );
};

export default UpdateInterestArea;
