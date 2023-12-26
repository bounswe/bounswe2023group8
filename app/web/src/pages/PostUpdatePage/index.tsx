import React, {useState} from "react";
import {useAuth} from "../../contexts/AuthContext";
import PostCreateCard from "../../components/Post/Create/PostCreateCard";
import {useLocation} from "react-router-dom";
import {useUpdatePost} from "../../hooks/usePost";
import {WikiTag} from "../InterestAreaViewPage";
import DetailedPostCardPreview from "../../components/Post/DetailedPostCardPreview";

const PostUpdatePage = () => {
    const {axiosInstance} = useAuth();
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
        isAgeRestricted
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
        isAgeRestricted: isAgeRestricted,
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
            <div className="col-6 mt-5 ms-1">
                <h3>Preview</h3>
                <DetailedPostCardPreview  content={postDetails.content}
                                          interestAreaId={interestArea.id} interestAreaTitle={interestArea.title}
                                          label={postDetails.label.toString()} sourceLink={postDetails.sourceLink} title={postDetails.title}/>
            </div>
        </div>
    );
};

export default PostUpdatePage;