import { useState } from 'react';
import { useQuery } from 'react-query'
import config from '../config';

export function useTranslatesQuery() {
  const [id, setId] = useState();
	const usersQuery= useQuery(['posts', id], () =>
    fetch(`${config.apiUrl}/api/translate/${id}`).then(res =>
      res.json()
    )
  );
	return [usersQuery, id, setId];
}

export async function recordData(sourceText){
  try {
    const response = await fetch(`${config.apiUrl}/api/translate`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(sourceText),
    });

    if (response.ok) {
      console.log('Response:', response.ok);
      // Process the response data
    } else {
      console.error('Error:', response.statusText);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

export async function getData(){
  try {
    const response = await fetch(`${config.apiUrl}/api/translate/all`);
    if (response.ok) {
      const data = await response.json()
      return data
      // Process the response data
    } else {
      console.error('Error:', response.statusText);
      return []
    }
  } catch (error) {
    console.error('Error:', error);
    return []
  }
}


export function useWikiSearchOptions() {


  const [searchInput, setSearchInput] = useState("");
	const searchOptionQuery= useQuery(['wikiSearch', searchInput], () =>
    fetch(`${config.apiUrl}/api/wiki/search/${searchInput}`).then(res =>
      res.json()
    )
  );
	return [searchOptionQuery, searchInput, setSearchInput];
}

