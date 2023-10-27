import React from "react";
import "./App.css";
import { BrowserRouter } from "react-router-dom";
import Router from "./Router";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap-icons/font/bootstrap-icons.css"

function App() {
  return (
    <BrowserRouter>
      <Router isUser={true}/>
    </BrowserRouter>
  );
}

export default App;
