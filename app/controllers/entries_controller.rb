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

  # localhost:3000/entry?id=n&date=some_date
  def show
    parsed_date = query_params_date_as_array
    @date = Date.new(parsed_date[0], parsed_date[1], parsed_date[2])
    if !id.blank?
      @entry = Entry.find(id)
    else
      @entry = Entry.new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      @entry = Entry.find(params[:id])
      if @entry.update_attributes(entry_params)
        format.js
        format.json { respond_with_bip(@entry) }
      end
    end
  end

  def destroy
    respond_to do |format|
      @entry = Entry.find(params[:id])
      if @entry.destroy
        format.js
      end
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :entry, :entry_date)
  end

  def query_params_date_as_array
    params[:date].split('-').map(&:to_i)
  end
end
