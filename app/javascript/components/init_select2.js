import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    // Add some debugging
    debug: true,
    // Allow the dropdown to properly appear over Bootstrap modals
    dropdownParent: $(document.body)
  });

  console.log('Select2 initialized on', $('.select2').length, 'elements');
};

export { initSelect2 };
