import Swal from 'sweetalert2'
window.Swal = Swal
$(document).on('turbolinks:load ready', () => {
  $('body').on('click', 'a.swal', function() {
    let element = $(this)
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.value) {
        if (this.dataset['swalSource']) {
          $(`#${this.dataset['swalSource']}`).trigger('click');
        }
        else {
          var swalLink = document.createElement('a');
          swalLink.href = element.attr('href');
          swalLink.setAttribute('data-method','delete')
          swalLink.click();
        }
      }
    });
    return false;
  });
});
