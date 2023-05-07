import { useState } from 'react';
import { useQuery } from 'react-query'
import config from '../config';



export function useUsersQuery() {


  const [id, setId] = useState();
	const usersQuery= useQuery(['posts', id], () =>
    fetch(`${config.apiUrl}/api/user/${id}`).then(res =>
      res.json()
    )
  );
	return [usersQuery, id, setId];
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

