class TodoListsController < ApplicationController
  include TodoListHelpers

  layout 'app'

  before_action :require_user
  before_action :set_todo_list

  def update
    new_todo_list = build_new_todo_list(todo_list_params)
    @list.update_with(new_todo_list)
    @list.save!
  end

  private

    def set_todo_list
      list = TodoList.find_by_user_id(current_user.id)
      @list = TodoListPresenter.new(list, reminder_setting: current_user.reminder_setting)
    end
end
