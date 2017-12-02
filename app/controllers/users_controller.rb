class UsersController < ApplicationController

  def index
  end

  def show
    @entry = Entry.new
    @entries = current_user.entries.reverse
    @date = Date.today
  end
end
