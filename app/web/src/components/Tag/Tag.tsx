import React from 'react'

type TagProps = {
    className: string,
    name: string,
}

const stringToRGBWithOpacity = (name: string, opacity: number): string | undefined => {
    let hash = 0;
    name.split('').forEach(char => {
        hash = char.charCodeAt(0) + ((hash << 5) - hash)
    })
    let colour = '#'
    for (let i = 0; i < 3; i++) {
        const value = (hash >> (i * 8)) & 0xff
        colour += value.toString(16).padStart(2, '0')
    }
    const rgb = colour.replace(/^#?([a-f\d])([a-f\d])([a-f\d])$/i
        , (m, r, g, b) => '#' + r + r + g + g + b + b)
        .substring(1).match(/.{2}/g)
        ?.map(x => parseInt(x, 16));

    let rgbaString;

    if (rgb)
        rgbaString = `rgba(${rgb[0]},${rgb[1]},${rgb[2]},${opacity})`

    return rgbaString;
}

const Tag = (props: TagProps) => {
    const {className, name} = props;
    const colour = stringToRGBWithOpacity(name, 0.6);
    return <p
        className={`rounded-4 text-center m-1 px-2 ${className}`}
        style={{backgroundColor: colour}}
    >
        #{name}
    </p>
}

export default Tag;
