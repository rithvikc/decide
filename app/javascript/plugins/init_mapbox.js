import mapboxgl from 'mapbox-gl';
import "mapbox-gl/dist/mapbox-gl.css"

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/arie9785/ckbenxi9v1mkt1imyv3i6dz0e',
      attributionControl: false,
      interactive: false,
    });

    map.on("load", () => {
      map.resize()
    })

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
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
    fitMapToMarkers(map, markers);
  }
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 40, maxZoom: 40, duration: 2000 });
};



export { initMapbox };
