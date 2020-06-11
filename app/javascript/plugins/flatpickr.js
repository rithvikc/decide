import flatpickr from "flatpickr";

flatpickr(".datepicker", {
  enableTime: true,
  dateFormat: "Y-m-d H:i",
  minDate: "today",
});
