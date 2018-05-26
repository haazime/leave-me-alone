import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['submit']

  initialize() {
    this.interval = 1000 * 1

    this.element.addEventListener('formchanged', (e) => {
      this.setSubmitter()
    })
    this.element.addEventListener('change', (e) => {
      this.setSubmitter()
    })
  }

  disconnect() {
    this.clearSubmitter()
  }

  setSubmitter() {
    this.clearSubmitter()
    this.submitTimer = setInterval(() => {
      this.submit()
      this.clearSubmitter()
    }, this.interval)
  }

  clearSubmitter() {
    if (this.submitTimer) {
      clearInterval(this.submitTimer)
    }
  }

  submit() {
    this.submitTarget.click()
  }
}
