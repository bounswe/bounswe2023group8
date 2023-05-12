import { useState } from 'react';
import { useQuery } from 'react-query';
import config from '../config';

export function useMarketSearch() {
    const [searchInput, setSearchInput] = useState('');

    const searchMarketQuery = useQuery(['wikiSearch', searchInput], async () => {
        if (searchInput.trim() === '') {
            return Promise.resolve(null);
        }

        const response = await fetch(`https://api.polygon.io/v2/aggs/ticker/${searchInput}/range/1/day/2023-01-09/2023-01-09?apiKey=zU5yH0bOuEGYnRBpqCxeRiuAAljoU_Rr`);
        if (!response.ok) {
            throw new Error('Stock not found!');
        }
        return response.json();
    });

    return [searchMarketQuery, searchInput, setSearchInput];
}

export async function addStarStock(userId, stock, value) {
    const response = await fetch(`${config.apiUrl}/api/stock/star`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            userId: userId,
            stock: stock,
            value: value,
        }),
    });
    const data = await response.json();

    if (!response.ok) {
        throw new Error(data.message || 'Failed to add star stock!');
    }

    return data;
}

export function useGetStarStocks(userId) {
    return useQuery(['getStarStocks', userId], async () => {
        const response = await fetch(`${config.apiUrl}/api/stock/star/all?userId=${userId}`);
        if (!response.ok) {
            throw new Error('Failed to fetch star stocks');
        }
        return response.json();
    });
}