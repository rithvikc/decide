import { Loader } from '@googlemaps/js-api-loader';
const initPlaces = () => {
  const placesInput = document.querySelector("#location")
  if (placesInput) {
    const loader = new Loader({
      apiKey: "AIzaSyB1T7ucuW8XzmGurRDWCG6650ECHt2bPzo",
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