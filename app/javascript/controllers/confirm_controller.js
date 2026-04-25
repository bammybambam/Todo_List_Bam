import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { message: String }

  show(event) {
    event.preventDefault()

    Swal.fire({
      title: 'Are you sure?',
      text: this.messageValue || "You won't be able to revert this!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#ef4444',
      cancelButtonColor: '#6b7280',
      confirmButtonText: 'Yes, delete it!',
      borderRadius: '16px'
    }).then((result) => {
      if (result.isConfirmed) {
        event.target.closest("form").requestSubmit()
      }
    })
  }
}