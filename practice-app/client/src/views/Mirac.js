import React, { useState, useEffect } from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import TextField from '@mui/material/TextField';
import { useAsterankSearchQuery, useSaveAsteroidMutation, useSavedAsteroidsQuery, useSavePlanetFactMutation, useSavedPlanetFactsQuery } from '../queries/mirac.query';

function Mirac() {
  const [searchTerm, setSearchTerm] = useState('');
  const { isLoading, searchResult } = useAsterankSearchQuery(searchTerm);
  const saveAsteroid = useSaveAsteroidMutation();
  const { isLoading: isLoadingSavedAsteroids, savedAsteroids } = useSavedAsteroidsQuery();
  const savePlanetFact = useSavePlanetFactMutation();
  const { isLoading: isLoadingSavedPlanetFacts, savedPlanetFacts } = useSavedPlanetFactsQuery();

  useEffect(() => {
    console.log('Search Result:', searchResult);
  }, [searchResult]);

  const handleSearchInputChange = (event, value) => {
    setSearchTerm(value);
  };

  const handleSaveAsteroid = (selectedAsteroid) => {
    saveAsteroid(selectedAsteroid);
  };

  const handleSavePlanetFact = (fact) => {
    savePlanetFact(fact);
  };

  return (
    <div>
      <Autocomplete
        options={searchResult}
        getOptionLabel={(option) => option.name}
        renderInput={(params) => (
          <TextField {...params} label="Search" variant="outlined" />
        )}
        onInputChange={handleSearchInputChange}
        loading={isLoading}
        onChange={(event, value) => handleSaveAsteroid(value)}
      />

      <div>
        <h2>Saved Asteroids</h2>
        {isLoadingSavedAsteroids ? (
          <p>Loading saved asteroids...</p>
        ) : (
          <ul>
            {savedAsteroids &&
              savedAsteroids.map((asteroid) => (
                <li key={asteroid.id}>{asteroid.name}</li>
              ))}
          </ul>
        )}
      </div>

      <div>
        <h2>Saved Planet Facts</h2>
        {isLoadingSavedPlanetFacts ? (
          <p>Loading saved planet facts...</p>
        ) : (
          <ul>
            {savedPlanetFacts &&
              savedPlanetFacts.map((fact) => (
                <li key={fact.id}>{fact.text}</li>
              ))}
          </ul>
        )}
      </div>
    </div>
  );
}

export default Mirac;
