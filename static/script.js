const clearButton = document.getElementById('clear-btn');
const locationField = document.getElementById('location');
const statusField = document.getElementById('status');
const phaseField = document.getElementById('phase');
const typeField = document.getElementById('type');
const sexField = document.getElementById('sex');
const ageField = document.getElementById('age');
const treatment_typeField = document.getElementById('treatment_type');
const start_dateField = document.getElementById('start_date');
const end_dateField = document.getElementById('end_date');

clearButton.addEventListener('click', function() {
    locationField.selectedIndex = 0;
    statusField.selectedIndex = 0;
    phaseField.selectedIndex = 0;
    typeField.selectedIndex = 0;
    sexField.selectedIndex = 0;
    ageField.selectedIndex = 0;
    treatment_typeField.selectedIndex = 0;

    start_dateField.value = '';
    end_dateField.value = '';
});