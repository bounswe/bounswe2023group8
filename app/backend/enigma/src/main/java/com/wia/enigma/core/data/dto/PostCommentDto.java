package com.wia.enigma.core.data.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class PostCommentDto {

    Long id;
    Long postId;
    EnigmaUserDto enigmaUser;
    String content;
    Timestamp createTime;
}
