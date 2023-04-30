package com.bounswe.group8.service;


import com.bounswe.group8.exception.custom.ResourceNotFoundException;
import com.bounswe.group8.mapper.PostMapper;
import com.bounswe.group8.mapper.UserMapper;
import com.bounswe.group8.model.Post;
import com.bounswe.group8.model.User;
import com.bounswe.group8.payload.PostCreateRequest;
import com.bounswe.group8.payload.dto.PostDto;
import com.bounswe.group8.payload.dto.UserDto;
import com.bounswe.group8.repository.PostRepository;
import com.bounswe.group8.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostService {

    final PostRepository postRepository;

    final UserRepository userRepository;

    /**
     * Get all posts. Should not be used in production due to performance issues.
     *
     * @return List of all posts
     */
    public List<PostDto> getAll() {

        List<Post> posts = postRepository.findAll();

        return posts.stream()
                .map(PostMapper::postToPostDto)
                .collect(Collectors.toList());
    }


    /**
     * Get post page. Constraints and defaults are set in the controller.
     *
     * @param page      Page number
     * @param size      Page size
     * @param sortBy    Sort by field
     * @param desc      Sort direction
     * @return          List of posts in the page
     */
    public List<PostDto> getPostPage(Integer page,
                                     Integer size,
                                     String sortBy,
                                     Boolean desc) {
        Sort sort;
        try {
            if (desc)
                sort = Sort.by(sortBy).descending();
            else
                sort = Sort.by(sortBy).ascending();
        } catch (Exception e) {
            sort = Sort.by("id");
        }

        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Post> postPage;

        try {
            postPage = postRepository.findAll(pageable);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            postPage = Page.empty();
        }

        return postPage.stream()
                .map(PostMapper::postToPostDto)
                .collect(Collectors.toList());
    }

    /**
     * Get post by id.
     *
     * @param id    Post id
     * @return      PostDto
     */
    public PostDto getPostById(Long id) {

        Post post = postRepository.findPostById(id);

        if (post == null)
            throw new ResourceNotFoundException("post", "id", id.toString());

        return PostMapper.postToPostDto(post);
    }

    /**
     * Update post by id. Title and content can be updated.
     *
     * @param id        Post id
     * @param title     Post title
     * @param content   Post content
     * @return          PostDto - updated post
     */
    public PostDto updatePostById(Long id,
                                  String title,
                                  String content) {

        Post post = postRepository.findPostById(id);

        if (post == null)
            throw new ResourceNotFoundException("post", "id", id.toString());

        boolean updated = false;

        if (title != null) {
            if (title.equals(post.getTitle()))
                throw new IllegalArgumentException("Title is the same");

            post.setTitle(title);
            updated = true;
        }

        if (content != null) {
            post.setContent(content);
            updated = true;
        }

        if (updated)
            postRepository.save(post);

        return PostMapper.postToPostDto(post);
    }

    /**
     * Create post.
     *
     * @param request   PostCreateRequest
     * @return          Post id - created post
     */
    public Long createPost(PostCreateRequest request) {

        User user = userRepository.findUserById(request.getUserId());

    	if (user == null)
            throw new ResourceNotFoundException("user", "id", request.getUserId().toString());

    	Post post = Post.builder()
                .title(request.getTitle())
                .content(request.getContent())
                .date(Timestamp.valueOf(LocalDateTime.now()))
                .user(user)
                .build();

    	Post saved = postRepository.save(post);

    	return saved.getId();
    }

    /**
     * Create post.
     *
     * @param title     Post title
     * @param content   Post content
     * @param userId    User id
     * @return          Post id - created post
     */
    public Long createPost(String title,
                           String content,
                           Long userId) {

        User user = userRepository.findUserById(userId);

        if (user == null)
            throw new ResourceNotFoundException("user", "id", userId.toString());

        Post post = Post.builder()
                .title(title)
                .content(content)
                .date(Timestamp.valueOf(LocalDateTime.now()))
                .user(user)
                .build();

        Post saved = postRepository.save(post);

        return saved.getId();
    }

    /**
     * Delete post by id.
     *
     * @param id    Post id
     * @return      PostDto - deleted post
     */
    public PostDto deletePostById(Long id) {

        Post post = postRepository.findPostById(id);

        if (post == null)
            throw new ResourceNotFoundException("post", "id", id.toString());

        User user = post.getUser();
        user.getPosts().remove(post);
        userRepository.save(user);
        postRepository.delete(post);

        return PostMapper.postToPostDto(post);
    }

}
