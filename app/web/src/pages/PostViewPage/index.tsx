import React, {useEffect} from 'react';
import { useParams } from 'react-router-dom';
import DetailedPostCard from '../../components/Post/DetailedPostCard';
import {useGetPost} from "../../hooks/usePost";
import {useAuth} from "../../contexts/AuthContext";

const PostViewPage = () => {
  const { postId } = useParams();

  const { axiosInstance} = useAuth();
  const {mutate, data} = useGetPost({});

  useEffect(() => {
    mutate({
      axiosInstance: axiosInstance,
      id: postId || "1",
    })

  }, [])

  return (
    <>
      <div style={{ display: 'flex' }} className="col-8">
        <div className="card-body overflow-y-auto">
          {data && <DetailedPostCard
            post={data}
          />}
        </div>
        <div className="card-body overflow-y-auto" >
        </div>
      </div>
    </>
  );
}

export default PostViewPage;
