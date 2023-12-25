import { AxiosInstance } from "axios";
import { useMutation } from "react-query";

export type GetTagSuggestionsProps = {
    axiosInstance: AxiosInstance,
    entityId: number,
    entityType: string, //INTEREST_AREA or POST
}

const getTagSuggestions = async ({axiosInstance, entityId, entityType}: GetTagSuggestionsProps) => {
    const params = new URLSearchParams({
        entityId: entityId.toString(),
        entityType: entityType
    }).toString();

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/tag-suggestion?${params}`,
    )

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

type useGetTagSuggestionsProps = {
    config?: any
}

export const useGetTagSuggestions = ({config}: useGetTagSuggestionsProps) => {
    return useMutation(getTagSuggestions, config);
}

export type AcceptTagSuggestionProps = {
    axiosInstance: AxiosInstance,
    tagSuggestionId: number,
}

const acceptTagSuggestion = async ({axiosInstance, tagSuggestionId}: AcceptTagSuggestionProps) => {
    const params = new URLSearchParams({
        tagSuggestionId: tagSuggestionId.toString()
    }).toString()

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/tag-suggestion/accept?${params}`,
    )

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }

}

type useAcceptTagSuggestionProps = {
    config?: any
}

export const useAcceptTagSuggestion = ({config}: useAcceptTagSuggestionProps) => {
    return useMutation(acceptTagSuggestion, config)
}

export type RejectTagSuggestionProps = {
    axiosInstance: AxiosInstance,
    tagSuggestionId: number,
}

const rejectTagSuggestion = async ({axiosInstance, tagSuggestionId}: RejectTagSuggestionProps) => {
    const params = new URLSearchParams({
        tagSuggestionId: tagSuggestionId.toString()
    }).toString()

    const response = await axiosInstance.get(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/tag-suggestion/reject?${params}`,
    )

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }

}

type useRejectTagSuggestionProps = {
    config?: any
}

export const useRejectTagSuggestion = ({config}: useRejectTagSuggestionProps) => {
    return useMutation(rejectTagSuggestion, config)
}


export type SuggestTagsProps = {
    axiosInstance: AxiosInstance,
    data: {
        entityId: number,
        entityType: number, //0 or 1
        tags: string[],
    }
}

const suggestTags = async ({axiosInstance, data}: SuggestTagsProps) => {
    const response = await axiosInstance.post(
        `${process.env.REACT_APP_BACKEND_API_URL}/v1/tag-suggestion`,
        data
    )

    if (response.status >= 200 && response.status < 300) {
        return response.data;
    }
}

type useSuggestTagsProps = {
    config?: any
}

export const useSuggestTags = ({config}: useSuggestTagsProps) => {
    return useMutation(suggestTags, config);
}
