import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["mapContainer"]
  static values = { lat: Number, lng: Number }

  connect() {
    if (typeof google === 'object' && typeof google.maps === 'object') {
      this.initMap();
    } else {
      window.initMap = this.initMap.bind(this);
      this.loadGoogleMapsScript();
    }
  }

  loadGoogleMapsScript() {
    const script = document.createElement('script');
    const apiKey = document.head.querySelector("meta[name='mapApiKey']").content;
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&loading=async&libraries=marker&callback=initMap`;
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);
  }

  initMap() {
    const initialLocation = { lat: 39.8283, lng: -98.5795 };

    this.map = new google.maps.Map(this.mapContainerTarget, {
      center: initialLocation,
      mapId: "COLLEGE_MAP_ID",
      zoom: 6,
    });
  }

  updateMap(event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    event.target.classList.add('visited');

    const lat = parseFloat(event.target.dataset.mapLatValue);
    const lng = parseFloat(event.target.dataset.mapLngValue);

    if (isNaN(lat) || isNaN(lng)) {
      console.error('Valid coordinates not provided.');
      return;
    }

    // Update map zoom, center and add marker
    const newLocation = { lat, lng };
    this.map.setZoom(18);
    this.map.setCenter(newLocation);
    new google.maps.marker.AdvancedMarkerElement({
      position: newLocation,
      map: this.map
    });
  }
}
