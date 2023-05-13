

/**
 * Uses AccuWeather's "Location API" to receive location keys according to search
 *
 * @param searchText                {string}
 * @returns {Promise<string[]>}     List of location info as formatted strings
 */
export const fetchLocationInfo = async (searchText) => {
    const response = await fetch(`http://dataservice.accuweather.com/locations/v1/cities/search?apikey=${process.env.REACT_APP_ACCU}&q=${searchText}`)
        .then(response => response.json());
    return response.map(element => {
        return {
            key: element.Key,
            city: element.EnglishName,
            country: element.Country.EnglishName
        };
    });
};

/**
 * Uses AccuWeather's "Forecast API" to receive the forecast data by the location key
 *
 * @param locationKey               {string}
 * @returns {Promise<number[]>}     List of forecast info
 */

export const fetchForecastInfo = async (locationKey) => {
    const response = await fetch(`http://dataservice.accuweather.com/forecasts/v1/daily/1day/${locationKey}?apikey=${process.env.REACT_APP_ACCU}&metric=true`)
        .then(response => response.json());
    return response.DailyForecasts.map(element => {
        return {
            high: element.Temperature.Maximum.Value,
            low: element.Temperature.Minimum.Value
        };
    });
};

/**
 * Creates a new forecast in the database with the given parameters
 *
 * @param city                  {string}
 * @param country               {string}
 * @param key                   {string}
 * @returns {Promise<number>}   status code
 */
export const saveForecast = async (city, country, high, low, date) => {

    return (await fetch(encodeURI(`/api/forecast`), {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            city: city,
            country: country,
            high: high,
            low: low,
            date: date
        })
    })).status;

};

/**
 * Deletes forecast in database by its key.
 *
 * @param key                   {string}
 * @returns {Promise<number>}   status code
 */
export const deleteSavedForecast = async (key) => {

    return (await fetch(encodeURI(`/api/forecast/delete/${key}`))).status;

};

/**
 * Gives the list of saved forecasts.
 *
 * @returns {Promise<localStorage>}     list of forecasts
 */
export const getSavedForecasts = async () => {

    return await fetch(encodeURI(`/api/forecast/all`))
        .then(response => response.json());

};
