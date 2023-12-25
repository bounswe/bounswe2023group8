package com.wia.enigma.dal.specification;

import com.wia.enigma.dal.entity.Moderation;
import org.springframework.data.jpa.domain.Specification;

public class ModerationSpecification {

    public static Specification<Moderation> isToEnigmaUserId(Long userId) {
        return (root, query, builder) -> builder.equal(root.get("toEnigmaUserId"), userId);
    }

    public static Specification<Moderation> isInterestAreaId(Long interestAreaId) {
        return (root, query, builder) -> builder.equal(root.get("interestAreaId"), interestAreaId);
    }

    public static Specification<Moderation> isModerationType(String type) {
        return (root, query, builder) -> builder.equal(root.get("moderationType"), type);
    }

    public static Specification<Moderation> isPostId(Long postId) {
        return (root, query, builder) -> builder.equal(root.get("postId"), postId);
    }

    public static Specification<Moderation> isFromEnigmaUserId(Long userId) {
        return (root, query, builder) -> builder.equal(root.get("fromEnigmaUserId"), userId);
    }
}
