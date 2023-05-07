import * as React from 'react';
import * as ReactDOM from 'react-dom/client';
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import { StyledEngineProvider } from '@mui/material/styles';
import App from './App';
import { QueryClient, QueryClientProvider } from 'react-query';


const queryClient = new QueryClient();


ReactDOM.createRoot(document.querySelector("#root")).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
    <StyledEngineProvider injectFirst>
      <App />
    </StyledEngineProvider>
    </QueryClientProvider>
  </React.StrictMode>
);