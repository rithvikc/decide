// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import { initPlaces } from '../plugins/init_gplaces_widget';

import { initSelect2 } from '../plugins/init_select2';

import { initEventCable } from '../channels/event_channel';
import { initSweetAlert } from '../plugins/init_sweetalert';
import { initArrowChange} from '../plugins/init_arrowchange';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
  initPlaces();
  initSelect2();
  initEventCable();
  initSweetAlert();
  initArrowChange();
  $(".category-choice").click(function(){
    $(this).toggleClass("active");
  });
})
