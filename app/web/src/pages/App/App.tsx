import React from "react";
import "./App.css";
import { BrowserRouter } from "react-router-dom";
import Router from "./Router";
import "bootstrap/dist/css/bootstrap.min.css";

function App() {
  return (
    <BrowserRouter>
      <Router />
    </BrowserRouter>
  );
}

export default App;
