import React, {
  createContext,
  useContext,
  useState,
  ReactNode,
  ReactElement,
  useCallback,
} from "react";
import axios, { AxiosInstance, AxiosRequestHeaders } from "axios";
import { FormData } from "../components/Register/RegisterModal";
import { LoginFormData } from "../components/Login/LoginModal";
import { useGetUser } from "../hooks/useUser";

interface AuthState {
  isAuthenticated: boolean;
  token: string | null;
  userId: number | null;
  authentication: {
    tokenType: string;
    accessToken: string;
    refreshToken: string;
    expiresIn: number;
  } | null;
}

type userData = {
  id: number;
  username: string;
  name: string;
  email: string;
  birthday: string;
  createTime: string;
};
interface AuthContextType extends AuthState {
  login: (data: LoginFormData) => Promise<void>;
  signup: (data: FormData) => Promise<void>;
  logout: () => void;
  axiosInstance: AxiosInstance;
  confirmSignupToken: (token: string) => Promise<void>;
  userData: userData;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface AuthProviderProps {
  children: ReactNode;
}

export const AuthProvider = ({ children }: AuthProviderProps): ReactElement => {
  const [authState, setAuthState] = useState<AuthState>({
    isAuthenticated: sessionStorage.getItem("token") ? true : false,
    token: sessionStorage.getItem("token"),
    userId: null,
    authentication: null,
  });
  const [userData, setUserData] = useState<userData>({
    id: parseInt(sessionStorage.getItem('id') || "-1"),
    username: "",
    name: sessionStorage.getItem("name") || "",
    email: "",
    birthday: "",
    createTime: "",
  });

  const axiosInstance = axios.create({
    baseURL: `${process.env.REACT_APP_BACKEND_API_URL}`,
    headers: {
      "Content-Type": "application/json",
    },
  });

  const { mutate } = useGetUser({
    axiosInstance: axiosInstance,
    userId: authState.userId as number,
    config: {
      onSuccess: (data: any) => {
        setUserData(data);
      },
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
      const params = new URLSearchParams({
        user: data.emailOrUsername,
        password: data.password,
      }).toString();

      const response = await axiosInstance.get(`/auth/signin?${params}`);
      const { userId, authentication } = response.data;
      setAuthState({
        isAuthenticated: true,
        token: authentication.accessToken,
        userId,
        authentication,
      });
      sessionStorage.setItem("token", authentication.accessToken);
      const newAxiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_BACKEND_API_URL}`,
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${authentication.accessToken}`,
        },
      });
      mutate(
        {
          axiosInstance: newAxiosInstance,
          userId: userId,
        },
        {
          onSuccess: (data: userData) => {
            setUserData(data);
            sessionStorage.setItem('id', data.id.toString());
            sessionStorage.setItem('name', data.name);
          },
        }
      );
    } catch (error) {
      console.error("Login failed:", error);
      throw error;
    }
  };

  const signup = async (data: FormData) => {
    try {
      await axiosInstance.post("/auth/signup", data);
    } catch (error) {
      console.error("Signup failed:", error);
      throw error;
    }
  };

  const logout = async () => {
    try {
      await axiosInstance.post("/auth/logout");
      setAuthState({
        userId: null,
        authentication: null,
        isAuthenticated: false,
        token: null,
      });
      setUserData({
          id: -1,
          username: "",
          name: "",
          email: "",
          birthday: "",
          createTime: "",
      })
      sessionStorage.clear();
    } catch (error) {
      console.error("Logout failed:", error);
      throw error;
    }
  };

  const confirmSignupToken = useCallback(
    async (token: string) => {
      try {
        const response = await axiosInstance.get(`/auth/verify?token=${token}`);
        const { userId, authentication } = response.data;
        setAuthState({
          isAuthenticated: true,
          token: authentication.accessToken,
          userId,
          authentication,
        });
        sessionStorage.setItem("token", authentication.accessToken);
      } catch (error) {
        console.error("Token confirmation failed:", error);
        throw error;
      }
    },
    [axiosInstance]
  );

  return (
    <AuthContext.Provider
      value={{
        ...authState,
        login,
        signup,
        logout,
        axiosInstance,
        userData,
        confirmSignupToken,
      }}
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
