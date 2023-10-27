import React, {
  createContext,
  useContext,
  useState,
  ReactNode,
  ReactElement,
} from "react";
import axios, { AxiosInstance, AxiosRequestHeaders } from "axios";
import { SignUpFormData } from "../components/Register/RegisterModal";
import { LoginFormData } from "../components/Login/LoginModal";

interface AuthState {
  isAuthenticated: boolean;
  token: string | null;
}

interface AuthContextType {
  authState: AuthState;
  login: (data: LoginFormData) => Promise<void>;
  signup: (data: SignUpFormData) => Promise<void>;
  logout: () => void;
  axiosInstance: AxiosInstance;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface AuthProviderProps {
  children: ReactNode;
}

const BACKEND_URL = "https://google.com";

export const AuthProvider = ({ children }: AuthProviderProps): ReactElement => {
  const [authState, setAuthState] = useState<AuthState>({
    isAuthenticated: false,
    token: null,
  });

  const axiosInstance = axios.create({
    baseURL: BACKEND_URL,
    headers: {
      "Content-Type": "application/json",
    },
  });

  axiosInstance.interceptors.request.use((config) => {
    if (authState.isAuthenticated && authState.token) {
      config.headers = {
        ...config.headers,
        Authorization: `Bearer ${authState.token}`,
      } as AxiosRequestHeaders;
    }
    return config;
  });

  const login = async (data: LoginFormData) => {
    try {
      const response = await axiosInstance.post("/login", data);
      const token = response.data.token;
      setAuthState({
        isAuthenticated: true,
        token,
      });
    } catch (error) {
      console.error("Login failed:", error);
      throw error;
    }
  };

  const signup = async (data: SignUpFormData) => {
    try {
      const response = await axiosInstance.post("/signup", data);
      const token = response.data.token;
      setAuthState({
        isAuthenticated: true,
        token,
      });
    } catch (error) {
      console.error("Signup failed:", error);
      throw error;
    }
  };

  const logout = () => {
    setAuthState({
      isAuthenticated: false,
      token: null,
    });
  };

  return (
    <AuthContext.Provider
      value={{ authState, login, signup, logout, axiosInstance }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
