import React, { useState, useEffect } from 'react';
import { Button } from '@mui/material';

function Omer() {
  const [movies, setMovies] = useState([]);
  const [page, setPage] = useState(1);

  useEffect(() => {
    async function fetchMovies() {
      const response = await fetch(
        `/api/movies/popular/${page}`
      );
      const json = await response.json();
      setMovies(json);
    }
    fetchMovies();
  }, [page]);

  function handlePageChange(newPage) {
    setPage(newPage);
  }

  return (
    <div>
      <h2>Get the list of the current popular movies on TMDB. This list updates daily.</h2>
      <div style={{margin: '20px '}}>
        <Button onClick={() => handlePageChange(page - 1)} disabled={page === 1} variant="contained" color="primary"> 
          Previous Page
        </Button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        {page}
        &nbsp;&nbsp;&nbsp;&nbsp;
        <Button onClick={() => handlePageChange(page + 1)} variant="contained" color="primary">
          Next Page
        </Button>
      </div>
      <div style={{display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gridGap: '20px'}}>
        {movies?.map((movie) => (
          <div key={movie.id} style={{border: '1px solid gray', borderRadius: '5px', padding: '10px'}}>
            <img src={`https://image.tmdb.org/t/p/w200${movie.posterPath}`} alt={movie.title} />
            <div style={{fontWeight: 'bold', margin: '10px 0'}}>{movie.title}</div>
            <div>Rating: {movie.rating}</div>
            <div>Release Date: {movie.releaseDate}</div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Omer;