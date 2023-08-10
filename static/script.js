const clearButton = document.getElementById('clear-btn');
const locationField = document.getElementById('location');
const statusField = document.getElementById('status');
const phaseField = document.getElementById('phase');
const typeField = document.getElementById('type');
const sexField = document.getElementById('sex');
const ageField = document.getElementById('age');
const treatmentTypeField = document.getElementById('treatment_type');
const startDateField = document.getElementById('start_date');
const endDateField = document.getElementById('end_date');
const tableRows = document.querySelectorAll('.table-body tr');

// Implementation of clear search filters button
if (clearButton) {
    clearButton.addEventListener('click', () => {
        locationField.selectedIndex = 0;
        statusField.selectedIndex = 0;
        phaseField.selectedIndex = 0;
        typeField.selectedIndex = 0;
        sexField.selectedIndex = 0;
        ageField.selectedIndex = 0;
        treatmentTypeField.selectedIndex = 0;
        startDateField.value = '';
        endDateField.value = '';
    });
}

// Implementation of linking table row to trial page
tableRows.forEach((row) => {
    row.addEventListener('click', () => {
        window.location = `./trialpage/${row.getAttribute('id')}`;
    });
});
