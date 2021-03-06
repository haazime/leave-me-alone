import { Controller } from 'stimulus'
import moment from 'moment'
import Push from 'push.js'

export default class extends Controller {
  static targets = ['subject']

  initialize() {
    Push.Permission.request()

    this.setRemindInterval()
    this.setReminder()

    this.subjectTarget.addEventListener('formchanged', (e) => {
      this.setReminder()
    })
    this.subjectTarget.addEventListener('change', (e) => {
      this.setReminder()
    })
  }

  disconnect() {
    this.clearReminder()
  }

  setReminder() {
    this.clearReminder()
    this.remindTimer = setInterval(() => {
      this.remind()
      this.clearReminder()
    }, this.remindInterval)
    this.data.set('at', moment().add(this.remindInterval, 'ms').format())
  }

  clearReminder() {
    if (this.remindTimer) {
      clearInterval(this.remindTimer)
    }
  }

  remind() {
    const controller = this
    Push.create('Leave me alone!', {
      link: '/todo_list',
      body: 'Todoリストを確認しましょう。',
      requireInteraction: true,
      onClick: function() {
        window.focus()
        this.close()
        controller.setReminder()
      }
    })
  }

  setRemindInterval() {
    const interval_in_minutes = parseInt(this.data.get('interval'))
    this.remindInterval = 1000 * 60 * interval_in_minutes
  }
}
