import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import { StyledEngineProvider } from '@mui/material/styles';
import App from './App';
import Baki from './views/Baki';
import Egemen from './views/Egemen';
import Begum from './views/Begum';
import Sude from './views/Sude';
import Furkan from './views/Furkan';
import Meric from './views/Meric';
import Mirac from './views/Mirac';
import Orkun from './views/Orkun';
import Bahri from './views/Bahri';
import Enes from './views/Enes';
import Bahadir from './views/Bahadir';
import Omer from './views/Omer';


const router = createBrowserRouter([
  {
    path: "/",
    element: <App/>,
  },
  {
    path: "/baki",
    element: <Baki/>,
  },
  {
    path: "/egemen",
    element: <Egemen/>,
  },
  {
    path: "/begüm",
    element: <Begum/>,
  },
  {
    path: "/sude",
    element: <Sude/>,
  },
  {
    path: "/furkan",
    element: <Furkan/>,
  },
  {
    path: "/meric",
    element: <Meric/>,
  },
  {
    path: "/mirac",
    element: <Mirac/>,
  },
  {
    path: "/orkun",
    element: <Orkun/>,
  },
  {
    path: "/bahri",
    element: <Bahri/>,
  },
  {
    path: "/enes",
    element: <Enes/>,
  },
  {
    path: "/bahadir",
    element: <Bahadir/>,
  },
    {
    path: "/omer",
    element: <Omer/>,
  },
]);

ReactDOM.createRoot(document.querySelector("#root")).render(
  <React.StrictMode>
    {/* <RouterProvider router={router} /> */}
    <StyledEngineProvider injectFirst>
      <App />
    </StyledEngineProvider>
  </React.StrictMode>
);