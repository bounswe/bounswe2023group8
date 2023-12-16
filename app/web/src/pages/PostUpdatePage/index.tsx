import React, {useEffect, useState} from "react";
import {useAuth} from "../../contexts/AuthContext";
import PostCreateCard, {
    CreatePostFormData,
} from "../../components/Post/Create/PostCreateCard";
import {SelectedLocationFormData} from "../../components/Geolocation/LocationPicker";
import {useLocation, useNavigate, useParams} from "react-router-dom";
import {useGetPost, useUpdatePost} from "../../hooks/usePost";
import {WikiTag} from "../InterestAreaViewPage";

const PostUpdatePage = () => {
    const {axiosInstance} = useAuth();
    const params = useParams();
    const defaultPostDetails: CreatePostFormData = {
        interestAreaId: -1,
        title: "",
        content: "",
        wikiTags: [],
        label: 1,
        sourceLink: "",
    };

    const defaultLocationDetails: SelectedLocationFormData = {
        latitude: 41,
        longitude: 29,
        address: "",
        locationSelected: false,
    };
    const propsFromParent = useLocation();
    const {post} = propsFromParent.state;
    const {
        id,
        interestArea,
        sourceLink,
        title,
        wikiTags,
        label,
        content,
        geolocation,
    }
        = post;

    const [postDetails, setPostDetails] = useState({
        interestAreaId: interestArea.id,
        title: title,
        content: content,
        wikiTags: wikiTags.map((tag: WikiTag) => {
            return {id: tag.id, name: tag.label}
        }),
        label: label,
        sourceLink: sourceLink,
    });
    const [locationDetails, setLocationDetails] = useState(
        { locationSelected: true, ...geolocation}
    );

    const mutateUpdatePost = useUpdatePost({}).mutate;

    const handleInputChange = (
        e:
            | React.ChangeEvent<HTMLInputElement>
            | React.ChangeEvent<HTMLSelectElement>
            | React.ChangeEvent<HTMLTextAreaElement>
    ) => {
        const {name, value} = e.target as typeof e.target & {
            value: string;
            name: string;
        };
        if (name === "publicationDate") {
            // setPostDetails({
            //   ...postDetails,
            //   [name]: new Date(value),
            // });
        } else {
            setPostDetails({
                ...postDetails,
                [name]: value,
            });
        }
    };

    const handleSubmit = (event: React.FormEvent) => {
        const wikiTagIds = postDetails.wikiTags.map((tag: WikiTag) => tag.id);
        event.preventDefault();
        mutateUpdatePost({
            axiosInstance,
            ...postDetails,
            wikiTags: wikiTagIds,
            geoLocation: {
                latitude: locationDetails.latitude,
                longitude: locationDetails.longitude,
                address: locationDetails.address,
            },
            id: id
        });

    };

    return (
        <div className="d-flex">
            <div className="container mt-4 col-6">
                <h2 className="fw-bold">Update Post</h2>
                <PostCreateCard
                    interestAreaId={interestArea.id}
                    interestAreaTitle={interestArea.title}
                    setPostDetails={setPostDetails}
                    postDetails={postDetails}
                    handleInputChange={handleInputChange}
                    handleSubmit={handleSubmit}
                    locationDetails={locationDetails}
                    setLocationDetails={setLocationDetails}
                    cardType={"update"}
                />
            </div>
            <div className="col-6 mt-5"></div>
        </div>
    );
};

export default PostUpdatePage;
