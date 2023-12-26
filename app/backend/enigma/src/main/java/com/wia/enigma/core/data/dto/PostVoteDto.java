package com.wia.enigma.core.data.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class PostVoteDto {

    Long id;
    Long postId;
    EnigmaUserDto enigmaUser;
    Boolean isUpvote;
}
