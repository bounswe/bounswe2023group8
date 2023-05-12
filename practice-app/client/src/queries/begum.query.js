import { useState } from 'react';
import { useQuery } from 'react-query';
import config from '../config';

export function useDictionarySearch() {
    const [searchInput, setSearchInput] = useState('');

    const searchDictionaryQuery = useQuery(['wikiSearch', searchInput], async () => {
        if (searchInput.trim() === '') {
            // searchInput boş ise isteği gönderme
            return Promise.resolve(null);
        }

        const response = await fetch(`https://api.dictionaryapi.dev/api/v2/entries/en/${searchInput}`);
        if (!response.ok) {
            throw new Error('Word not found!');
        }
        return response.json();
    });

    return [searchDictionaryQuery, searchInput, setSearchInput];
}

export async function addFavouriteWord(userId, word, meaning) {
    const response = await fetch(`${config.apiUrl}/api/word/favourite`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            userId: userId,
            word: word,
            meaning: meaning,
        }),
    });
    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || 'Failed to add favorite word!');
    }

    return data;
}

export function useGetFavouriteWords(userId) {
    return useQuery(['getFavouriteWords', userId], async () => {
        const response = await fetch(`${config.apiUrl}/api/word/favourite/all?userId=${userId}`);
        if (!response.ok) {
            throw new Error('Failed to fetch favourite words');
        }
        return response.json();
    });
}
