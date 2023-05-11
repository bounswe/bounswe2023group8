import React from 'react';
import TextField from '@mui/material/TextField';

import { useDictionarySearch } from '../queries/begum.query';
import { mean } from 'lodash';

function Begum() {
    const [searchDictionaryQuery, searchInput, setSearchInput] = useDictionarySearch();

    return (
        <div>
            <TextField
                id="outlined-controlled"
                label="Search"
                value={searchInput}
                onChange={(event) => {
                    setSearchInput(event.target.value);
                }}
            />
            {
                searchDictionaryQuery.isError &&
                <div style={{ fontWeight:"bold", color: "red" }}>
                    {searchDictionaryQuery.error.message}
                </div>
            }
            {
                searchDictionaryQuery.isSuccess &&
                searchDictionaryQuery.data &&
                !searchDictionaryQuery.data.title &&
                searchDictionaryQuery.data.map((result) => {
                    return result.meanings.map((meaning) => {
                        return (
                            <div>
                                <div style={{ fontWeight:"bold" }}>{"Type: " + meaning.partOfSpeech }</div>
                                {meaning.definitions.map((definition, index) => {
                                    return <div>{"Meaning #" + index + ": "}{definition.definition}</div>
                                })}
                            </div>
                        );
                    });
                })
            }
        </div>
    );
}

export default Begum;
