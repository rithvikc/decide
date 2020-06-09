import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => {
    bounds.extend([ marker.lng, marker.lat ]);
  });
  map.fitBounds(bounds, {padding: 70, maxZoom: 15, duration: 2000 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const markers = JSON.parse(mapElement.dataset.markers);
    const firstMarker = markers[0]
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/rithvik/ckb0ayc9r0kpd1ilgsod48oym',
      center: [firstMarker['lng'], firstMarker['lat']], //ideally we want to fitmaptomarkers
      zoom: 10
    });


    // Create a HTML element for your custom marker

    markers.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '40px';
      element.style.height = '40px';

      new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
    });

    fitMapToMarkers(map, markers)

    }

}

// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
//   map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
// };

// if (mapElement) {
//   // [ ... ]
//   fitMapToMarkers(map, markers);
// }



export { initMapbox };
