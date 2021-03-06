require 'rails_helper'

describe 'Set reminder', type: :system, js: true do
  before { sign_in(sign_up) }

  it do
    visit setting_path
    select '25', from: 'form[remind_interval]'
    click_on '保存する'

    expect(page).to have_select('form[remind_interval]', selected: '25')

    visit todo_list_path
    expect_reminder_scheduled(25.minutes)
  end
end
