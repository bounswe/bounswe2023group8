import { useState } from 'react';
import { useQuery, useMutation, queryCache } from 'react-query';
import config from '../config';

export function useAsterankSearchQuery(searchTerm) {
const [searchResult, setSearchResult] = useState([]);

const { isLoading, isError, data, error } = useQuery(
['asterankSearch', searchTerm],
() =>
fetch(${config.apiUrl}/api/asteroids?query=${searchTerm}).then((res) =>
res.json()
)
);

if (isError) {
console.error('An error occurred while fetching asteroid data:', error);
}

useEffect(() => {
if (data) {
setSearchResult(data);
}
}, [data]);

return { isLoading, searchResult };
}

export function useSaveAsteroidMutation() {
const saveAsteroidMutation = useMutation((asteroidData) =>
fetch(${config.apiUrl}/api/asteroids, {
method: 'POST',
headers: {
'Content-Type': 'application/json',
},
body: JSON.stringify(asteroidData),
}).then((res) => res.json())
);

const saveAsteroid = async (asteroidData) => {
await saveAsteroidMutation.mutateAsync(asteroidData);
queryCache.invalidateQueries('asterankSearch');
};

return saveAsteroid;
}

export function useSavedAsteroidsQuery() {
const { isLoading, isError, data, error } = useQuery('savedAsteroids', () =>
fetch(${config.apiUrl}/api/asteroids/saved).then((res) => res.json())
);

if (isError) {
console.error('An error occurred while fetching saved asteroids:', error);
}

return { isLoading, savedAsteroids: data };
}

export function useSavePlanetFactMutation() {
const savePlanetFactMutation = useMutation((factData) =>
fetch(${config.apiUrl}/api/planets/facts, {
method: 'POST',
headers: {
'Content-Type': 'application/json',
},
body: JSON.stringify(factData),
}).then((res) => res.json())
);

const savePlanetFact = async (factData) => {
await savePlanetFactMutation.mutateAsync(factData);
queryCache.invalidateQueries('savedPlanetFacts');
};

return savePlanetFact;
}

export function useSavedPlanetFactsQuery() {
const { isLoading, isError, data, error } = useQuery(
'savedPlanetFacts',
() =>
fetch(${config.apiUrl}/api/planets/facts/saved).then((res) =>
res.json()
)
);

if (isError) {
console.error('An error occurred while fetching saved planet facts:', error);
}

return { isLoading, savedPlanetFacts: data };
}