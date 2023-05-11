import { useState } from 'react';
import { useQuery } from 'react-query'
import config from '../config';


export function useDictionarySearch() {

    const [searchInput, setSearchInput] = useState("");

    const searchDictionaryQuery = useQuery(['wikiSearch', searchInput], () =>
        fetch(`https://api.dictionaryapi.dev/api/v2/entries/en/${searchInput}`).then(res => {
            if (!res.ok) {
                throw new Error('Word not found!');
            }
            return res.json();
        })
    );

    return [searchDictionaryQuery, searchInput, setSearchInput];
}