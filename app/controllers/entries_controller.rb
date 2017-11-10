class EntriesController < ApplicationController
  def index
  end

  def new
  end

  def create
    respond_to do |format|
      @entry = current_user.entries.new(entry_params)
      if @entry.save
        format.js
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      @entry = Entry.find(params[:id])
      if @entry.update_attributes(entry_params)
        format.js
      end
    end
  end

  def destroy
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :entry)
  end
end
