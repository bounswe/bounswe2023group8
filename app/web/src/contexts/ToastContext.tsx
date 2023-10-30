import React from 'react';


type ToastFieldTypes = {message: string, display: boolean, isError: boolean};
interface ToastState {
    toastState: ToastFieldTypes[];
    setToastState: React.Dispatch<React.SetStateAction<ToastFieldTypes[]>>;
}


const ToastContext = React.createContext<ToastState | undefined>(undefined);

export const useToastContext =(): ToastState => {
    const context = React.useContext(ToastContext);
    if (!context) {
        throw new Error("useToastContext must be used within an AppContextProvider");
    }
    return context;
}

export function ToastContextProvider({ children }: { children: React.ReactNode }) {
    const [toastState, setToastState] = React.useState<ToastFieldTypes[]>([]);

    return (
        <ToastContext.Provider value={{ toastState, setToastState }}>
            {children}
        </ToastContext.Provider>
    );
}
