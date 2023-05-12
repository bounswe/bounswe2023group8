import React, { useState } from "react";
import { Button, TextField } from "@mui/material";
import axios from "axios";
import config from "../config";

function Sude() {
  const [num, setNum] = useState("");
  const [info, setInfo] = useState("");
  const [most, setMost] = useState("");

  const sendData = () => {
    axios
      .post(`${config.apiUrl}/api/numbers`, {
        searchedNumber: num,
      })
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        console.log(error, error.response);
      });
  };

  const getData = () => {
    axios
      .get(`${config.apiUrl}/api/numbers/max`)
      .then((response) => {
        setMost(response.data.searchedNumber);
      })
      .catch((error) => {
        console.log(error, error.response);
      });
  };

  function handleClick() {
    if (num != "") {
      sendData();
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
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: 10,
        fontFamily: "monospace",
        fontSize: 20,
      }}
    >
      <h2>Fun Facts About Numbers😀</h2>
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
      <div style={{ marginTop: 20, display: "flex", gap: 20, alignItems: "center" }}>
        <Button variant="contained" onClick={getData}>
          See the most searched number
        </Button>
        <div
          style={{
            border: "solid",
            borderRadius: 5,
            paddingLeft: 6,
            paddingRight: 6,
          }}
        >
          {most}
        </div>
      </div>
    </div>
  );
}

export default Sude;
