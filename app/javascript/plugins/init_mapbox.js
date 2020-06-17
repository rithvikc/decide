import mapboxgl from 'mapbox-gl';
import "mapbox-gl/dist/mapbox-gl.css"

const fitMapToMarkers = (map, markers, locationMarker) => {
  if (locationMarker) {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([locationMarker.lng, locationMarker.lat])
    map.fitBounds(bounds, { padding: {bottom: 100}, maxZoom: 12, duration: 400 });
  }
  else {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 100, maxZoom: 12, duration: 400 });
  }
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const markers = JSON.parse(mapElement.dataset.markers);
    var last_element = markers[markers.length - 1];
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/rithvik/ck9xrhxz91pgp1inyh8u8z8d1',
      attributionControl: false,
      center: [last_element.lng, last_element.lat]
    });

    map.on("load", () => {
      map.resize()
    })

    markers.forEach((marker, index) => {
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    const location_marker = (mapElement.dataset.locationMarker) ? JSON.parse(mapElement.dataset.locationMarker) : null;

    if (location_marker) {
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${location_marker.image_url}')`;
      element.style.backgroundSize = 'contain';

      element.style.width = '50px';
      element.style.height = '50px';
      var popup = new mapboxgl.Popup({
        closeOnClick: false,
        closeButton: false
      })
      .setLngLat([ location_marker.lng, location_marker.lat ])
      .setHTML(location_marker.info_window_html)
      .addTo(map);

      new mapboxgl.Marker(element)
        .setLngLat([ location_marker.lng, location_marker.lat ])
        .addTo(map);
    }
    fitMapToMarkers(map, markers, location_marker);
  }
};


export { initMapbox };
