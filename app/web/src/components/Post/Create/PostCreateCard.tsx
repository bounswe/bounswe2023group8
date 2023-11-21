import React, {useState} from 'react';
import Tag from "../../Tag/Tag";
import LocationPicker, {SelectedLocationFormData} from "../../Geolocation/LocationPicker";
import {Card, CardBody} from "react-bootstrap";

export type CreatePostFormData = {
    interestArea: string;
    title: string;
    link: string;
    description: string;
    tags: string[];
    label: string;
    source: string;
    publicationDate: Date;
};

export type PostCreateCardProps = {
    handleSubmit: (_: React.FormEvent) => void;
    postDetails: CreatePostFormData;
    setPostDetails: React.Dispatch<React.SetStateAction<CreatePostFormData>>;
    handleInputChange: (e:
                            | React.ChangeEvent<HTMLInputElement>
                            | React.ChangeEvent<HTMLSelectElement>
                            | React.ChangeEvent<HTMLTextAreaElement>
    ) => void;
    locationDetails: SelectedLocationFormData;
    setLocationDetails: React.Dispatch<React.SetStateAction<SelectedLocationFormData>>;
    cardType: "create" | "update"
}
const PostCreateCard = ({
                            handleInputChange, handleSubmit, postDetails,
                            setPostDetails, locationDetails, setLocationDetails,
                            cardType
                        }: PostCreateCardProps) => {

    const defaultLocationDetails: SelectedLocationFormData = {
        latitude: 41,
        longitude: 29,
        address: "",
        locationSelected: false
    }
    const [showLocationPickerModal, setShowLocationPickerModal] = useState(false);
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

    const removeTag = (indexToRemove: number) => {
        setPostDetails({
            ...postDetails,
            tags: postDetails.tags.filter((element, index) => index != indexToRemove)
        })
    }

    return <Card className="border-3 border-primary-subtle">
        <CardBody className="">
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
                        style={{gap: "0.5rem"}}
                    >
                        <div
                            className="d-flex flex-wrap flex-grow-1"
                            style={{gap: "0.5rem"}}
                        >
                            {postDetails.tags.map((tag, index) => (
                                <div key={index} className="m-2" style={{cursor: "pointer"}}
                                     onClick={() => removeTag(index)}>
                                    <Tag className={""} name={tag}/>
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
                                style={{width: "150px"}} // Fixed width for input
                            />
                            <button
                                type="button"
                                className="btn btn-secondary"
                                onClick={addTag}
                                style={{marginLeft: "0.5rem"}} // Add margin to separate from input
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
                        type="button"
                        onClick={() => setShowLocationPickerModal(!showLocationPickerModal)}
                    >
                        {locationDetails.locationSelected ? "Change Location" : "Add Location"}
                    </button>
                    <span className="px-2"> {locationDetails.address} </span>
                    {locationDetails.locationSelected &&
                        <button
                            className="btn btn-secondary"
                            type="button"
                            onClick={() => {
                                setLocationDetails(defaultLocationDetails);
                            }}
                        >Delete Location</button>}

                </div>

                <div className="d-flex justify-content-center">
                    <button type="submit" className="btn btn-primary">
                        {cardType == "create" && "Create Post"}
                        {cardType == "update" && "Update Post"}
                    </button>
                </div>
            </form>
            <LocationPicker showLocationPickerModal={showLocationPickerModal}
                            setShowLocationPickerModal={setShowLocationPickerModal}
                            locationFormData={locationDetails}
                            setLocationFormData={setLocationDetails}/>
        </CardBody>
    </Card>
}

export default PostCreateCard;
