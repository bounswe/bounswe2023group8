import React, { useState } from "react";
import { Button, TextField } from "@mui/material";
import axios from "axios";

function Sude() {
  const [num, setNum] = useState("");
  const [info, setInfo] = useState("");

  function handleClick() {
    if (num != "") {
      axios
        .get(`http://numbersapi.com/${num}`)
        .then((response) => {
          setInfo(response.data);
        })
        .catch((error) => {
          console.log(error, error.response);
        });
    }
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
      <h3>Fun Facts About Numbers😀</h3>
      <div style={{ display: "flex", gap: 10 }}>
        <TextField
          id="outlined-controlled"
          label="Input Number"
          value={num}
          onChange={(event) => {
            setNum(event.target.value);
          }}
        />
        <Button variant="contained" onClick={handleClick}>
          Search
        </Button>
      </div>
      <div>{info}</div>
    </div>
  );
}

export default Sude;
