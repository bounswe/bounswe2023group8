package com.wia.enigma.core.data.request;


import com.wia.enigma.dal.enums.EntityType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ReportRequest {

    Long entityId;

    String entityType;

    String reason;
}
