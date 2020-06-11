import { Loader } from '@googlemaps/js-api-loader';
require('dotenv').config();
const initPlaces = () => {
  const placesInput = document.querySelector("#location")
  if (placesInput) {
    const loader = new Loader({
      apiKey: process.env.GPLACES_KEY,
      version: "weekly",
      libraries: ["places"]
    });
    loader
      .load()
      .then(() => {
        new google.maps.places.Autocomplete(placesInput);
      })
      .catch(e => {
        console.log(e)
      });
  }
}
export { initPlaces };
