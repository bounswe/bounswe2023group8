import React from "react";
import "./App.css";
import {BrowserRouter} from "react-router-dom";
import Router from "./Router";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap-icons/font/bootstrap-icons.css";
import {AuthProvider} from "../../contexts/AuthContext";
import {QueryClient, QueryClientProvider} from "react-query";
import {ToastContextProvider} from "../../contexts/ToastContext";

function App() {
    const queryClient = new QueryClient();

    return (
        <ToastContextProvider>
            <QueryClientProvider client={queryClient}>
                <AuthProvider>
                    <BrowserRouter>
                        <Router/>
                    </BrowserRouter>
                </AuthProvider>
            </QueryClientProvider>
        </ToastContextProvider>
    );
}

export default App;
