import React from "react";
import PostPreviewCard from "../../components/Post/PostSmallPreview/PostPreviewCard";
import mockPosts from "../../mockData/milestone1/451_posts.json";
import mockUsers from "../../mockData/milestone1/451_users.json";
import mockTags from "../../mockData/milestone1/451_tags.json";
const TimelineHomePage: React.FC = () => {
  const getRandomPosts = (count: number) => {
    const shuffledPosts = mockPosts.sort(() => 0.5 - Math.random());
    return shuffledPosts.slice(0, count);
  };

  const getRandomTags = (count: number) => {
    const shuffledTags = mockTags.sort(() => 0.5 - Math.random());
    return shuffledTags.slice(0, count);
  };

  type postTypes = {
    id: number;
    user_id: number;
    ia_ids: number[];
    source_link: string;
    content: string;
    created_at: string;
  };

  const getUserName = (post: postTypes): string | undefined => {
    return mockUsers.find((user) => user.id === post.user_id)?.name;
  };

  const randomPosts = getRandomPosts(10); // Adjust the count as needed

  const randomTagsAbove = getRandomTags(4);
  const randomTagsBelow = getRandomTags(4);

    return (
        <div className="container mt-3">
            {/*{randomPosts.map((post) => (*/}
            {/*    <div key={post.id} className="mb-4">*/}
            {/*        <PostPreviewCard*/}
            {/*            post={post}*/}
            {/*            userName={getUserName(post)}*/}
            {/*            tags={getRandomTags(8)}*/}
            {/*            //tagsAbove={randomTagsAbove}*/}
            {/*            //tagsBelow={randomTagsBelow}*/}
            {/*            // Additional props as needed*/}
            {/*        />*/}
            {/*    </div>*/}
            {/*))}*/}
      {/*  </div>*/}
      {/*))}*/}
    </div>
  );
};

export default TimelineHomePage;
