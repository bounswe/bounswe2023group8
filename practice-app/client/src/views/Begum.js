import React, { useState } from 'react';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import { useDictionarySearch, addFavouriteWord, useGetFavouriteWords } from '../queries/begum.query';

function Begum() {
    const [searchDictionaryQuery, searchInput, setSearchInput] = useDictionarySearch();
    const [isWordAdded, setIsWordAdded] = useState(false);
    const { data: favouriteWords } = useGetFavouriteWords(1); // Replace with the actual user ID

    const handleAddToFavorites = async (word) => {
        if (word.trim() === '') {
            console.error('You did not enter a word!');
            return;
        }

        if (favouriteWords && favouriteWords.some((favWord) => favWord.word === word)) {
            console.error('Word already added to favorites!');
            return;
        }

        try {
            await addFavouriteWord(1, word, ''); // Replace with the actual user ID and meaning
            setIsWordAdded(true);
        } catch (error) {
            console.error('Error while adding favorite word:', error);
        }
    };

    return (
        <div>
            <TextField
                id="outlined-controlled"
                label="Search"
                value={searchInput}
                onChange={(event) => {
                    setSearchInput(event.target.value);
                    setIsWordAdded(false);
                }}
            />
            <Button variant="contained" onClick={() => handleAddToFavorites(searchInput)}>
                Add to Favourites
            </Button>
            {searchDictionaryQuery.isError && searchInput && (
                <div style={{ fontWeight: 'bold', color: 'red' }}>
                    {searchDictionaryQuery.error.message}
                </div>
            )}
            {searchDictionaryQuery.isSuccess &&
                searchDictionaryQuery.data &&
                !searchDictionaryQuery.data.title &&
                searchDictionaryQuery.data.map((result) => {
                    return result.meanings.map((meaning) => {
                        return (
                            <div>
                                <div style={{ fontWeight: 'bold' }}>{"Type: " + meaning.partOfSpeech}</div>
                                {meaning.definitions.map((definition, index) => {
                                    return <div>{"Meaning #" + index + ": "}{definition.definition}</div>;
                                })}
                            </div>
                        );
                    });
                })}
            {isWordAdded && <div style={{ fontWeight: 'bold', color: 'green' }}>Word added to favorites!</div>}
            <h2>Favourite Words</h2>
            {favouriteWords && favouriteWords.map((word) => (
                <div key={word.id}>
                    <div>{word.word}</div>
                    <div>{word.meaning}</div>
                </div>
            ))}
        </div>
    );
}

export default Begum;
