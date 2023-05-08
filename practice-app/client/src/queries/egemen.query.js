
export const fetchAddresses = async ({lat, lng}, googleMapsApiKey) => {
  console.log('fetching');
  const response = await fetch(`https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${googleMapsApiKey}`);
  const result = await response.json();
  return [...new Set(result.results.map(element => element.formatted_address))];
}
