
/**
 * Uses Google's "Maps JavaScript API" to receive addresses available
 * around the given latitude and longitude values.
 *
 * @param latitude                  {number}
 * @param longitude                 {number}
 * @param googleMapsApiKey          {string}
 * @returns {Promise<string[]>}     List of addresses as formatted strings
 */
export const fetchAddresses = async (latitude, longitude, googleMapsApiKey) => {
  const response = await fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${googleMapsApiKey}`)
    .then(response => response.json());
  return [...new Set(response.results.map(element => element.formatted_address))];
};

/**
 * Gives the number of addresses saved under the given title.
 *
 * @param title                 {string}
 * @returns {Promise<number>}   number of addresses
 */
export const getNumberOfLocationsForTitle = async (title) => {
  const response = await fetch(encodeURI(`http://localhost:8081/api/location/${title}/count`))
    .then(response => response.json());
  return response;
};

/**
 * Creates a new address in the database with the given parameters
 *
 * @param latitude              {number}
 * @param longitude             {number}
 * @param address               {string}
 * @param title                 {string}
 * @returns {Promise<number>}   status code
 */
export const addNewAddress = async (latitude, longitude, address, title) => {

  const statusCode = (await fetch(encodeURI("http://localhost:8081/api/location"), {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      latitude: latitude,
      longitude: longitude,
      address: address,
      title: title
    })
  })).status;

  return statusCode;

};
