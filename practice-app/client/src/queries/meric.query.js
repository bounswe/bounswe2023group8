import config from "../config";

/**
 * Uses AccuWeather's "Location API" to receive location keys according to search
 *
 * @param searchText                {string}
 * @param accuWeatherApiKey         {string}
 * @returns {Promise<string[]>}     List of location info as formatted strings
 */
export const fetchLocationInfo = async (searchText, accuWeatherApiKey) => {
  const response = await fetch(`http://dataservice.accuweather.com/locations/v1/cities/search?apikey=${accuWeatherApiKey}&q=${searchText}`)
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
 * @param accuWeatherApiKey         {string}
 * @returns {Promise<number[]>}     List of forecast info
 */

export const fetchForecastInfo = async (locationKey, accuWeatherApiKey) => {
  const response = await fetch(`http://dataservice.accuweather.com/forecasts/v1/daily/1day/${locationKey}?apikey=${accuWeatherApiKey}&metric=true`)
    .then(response => response.json());
  return response.DailyForecasts.map(element => {
    return {
        high: element.Temperature.Maximum.Value,
        low: element.Temperature.Minimum.Value
    };
  });
};
