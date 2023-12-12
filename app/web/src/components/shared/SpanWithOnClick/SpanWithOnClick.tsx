import React from 'react';

type SpanWithOnClickProps = {
    className: string
    text: string;
    onClick: () => void;
}
const SpanWithOnClick = (props: SpanWithOnClickProps) => {
    return <span
        className={props.className}
        style={{cursor:"pointer", color: "#0B68B1"}}
        onClick={props.onClick}
    >
        {props.text}
    </span>;
}

export default SpanWithOnClick;
