import React from 'react'

type LabelProps = {
    className: string,
    label: string,
}


const Label = (props: LabelProps) => {
    const {className, label} = props;
    return <span
        className={`rounded-4 text-center p-1 px-2 WA-theme-bg-solid WA-theme-light ${className}`}
    >
        {label}
    </span>
}

export default Label;
