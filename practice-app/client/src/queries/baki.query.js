import { useState } from 'react';
import { useQuery } from 'react-query'
import { useMutation } from 'react-query';
import { useQueryClient } from 'react-query';
import config from '../config';

export function useWikiSearchOptions() {

  const [searchInput, setSearchInput] = useState("");
	const searchOptionQuery= useQuery(['wikiSearch', searchInput], () =>
    fetch(`${config.apiUrl}/api/wiki/search/${searchInput}`).then(res =>
      res.json()
    ),{

        enabled: searchInput!=null && searchInput!=undefined && searchInput.length>0
    }
  );
	return [searchOptionQuery, searchInput, setSearchInput];
}

export function useWikiEntity() {

  const [id, setId] = useState("");
	const searchOptionQuery= useQuery(['wikiEntity', id], () =>
    fetch(`${config.apiUrl}/api/wiki/entity/${id}`).then(res =>
      res.json()
    ),{

        enabled: id!=null && id!=undefined && id.length>0
    }
  );
	return [searchOptionQuery, id, setId];
}

export function useWikiProperties() {


  const [ids, setIds] = useState("");
	const searchPropertiesQuery= useQuery(['wikiProperties', ids], () =>
    fetch(`${config.apiUrl}/api/wiki/entity/${ids}`).then(res =>
      res.json()
    ),{

        enabled: ids!=null && ids!=undefined && ids.length>0
    }
  );
	return [searchPropertiesQuery, ids, setIds];
}


export function useBookmarks() {


	const bookmarksQuery= useQuery('bookmarks', () =>
    fetch(`${config.apiUrl}/api/wiki/bookmarks/all`).then(res =>
      res.json()
    )
  );
	return bookmarksQuery;
}

export const useCreateEntityMutation = () => {

  function createEntity(data) {

	const requestOptions = {
		method: 'POST',
		headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data),
	};

	return fetch(`${config.apiUrl}/api/wiki`, requestOptions);
}

  const queryClient = useQueryClient();

  const { mutate: createBookmark } = useMutation(createEntity,  {
   onSuccess: () => { console.log("successful"); queryClient.invalidateQueries('bookmarks' )}
  });


   return createBookmark;
};

export const useDeleteAllBookmarksMutation= () => {

  function deleteBookmarks() {

	const requestOptions = {
		method: 'DELETE',
		headers: {
      'Content-Type': 'application/json',
    },
	};

	return fetch(`${config.apiUrl}/api/wiki/bookmarks/all`, requestOptions);
}

  const queryClient = useQueryClient();

  const { mutate: deleteAllBookmarks } = useMutation(deleteBookmarks,  {
   onSuccess: () => { console.log("successful"); queryClient.invalidateQueries('bookmarks' )}
  });

   return deleteAllBookmarks;
};


export const useDeleteBookmarkMutation= () => {

  function deleteBookmark(code) {

	const requestOptions = {
		method: 'DELETE',
		headers: {
      'Content-Type': 'application/json',
    },
	};

	return fetch(`${config.apiUrl}/api/wiki/bookmarks/${code}`, requestOptions);
}

  const queryClient = useQueryClient();

  const { mutate: deleteBookmarkByCode} = useMutation(deleteBookmark,  {
   onSuccess: () => { console.log("successful"); queryClient.invalidateQueries('bookmarks' )}
  });

   return deleteBookmarkByCode;
};



