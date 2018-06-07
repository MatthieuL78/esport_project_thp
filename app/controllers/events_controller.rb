# frozen_string_literal: true

require 'google_drive'

class EventsController < ApplicationController
  before_action :set_event, only: %I[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def data_create; end

  def save_data_from_spreadsheet
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]
    2.upto(10) do |row|
      event = Event.new
      1.upto(7) do |col|
        case col
        when 1
          event.name = ws[row, col]
        when 2
          event.image = ws[row, col]
        when 3
          event.date = ws[row, col]
        when 4
          event.attendee = ws[row, col]
        when 5
          event.place = ws[row, col]
        when 6
          event.game = ws[row, col]
        else
          event.style = ws[row, col]
        end
      end
      event.save
    end
    redirect_to events_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.fetch(:event, {})
  end
end
