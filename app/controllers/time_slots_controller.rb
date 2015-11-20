class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: [:show, :edit, :update, :create_from_existing, :destroy]
  # before_action :set_time_slot, except: [:index, :new, :create, :create_from_availability]


  #### UNDER CONSTRUCTION
  # GET /time_slots
  # GET /time_slots.json
  # .json is created specifically for calendar usage
  def index
    
    if current_dietitian 
      @time_slots = TimeSlot.order('start_time DESC').where(status: "Current").where(vacancy: true).where(minutes: 30)

    #  Review all current 30 minute time slots
    elsif params[:minutes] == "30" && params[:type] == "Review"
      @cal_time_slots = TimeSlot.order('start_time DESC').where(status: "Current").where(minutes: 30)

    #  review all current 60 minute, current time slots
    elsif params[:minutes] == "60" && params[:type] == "Review"
      @cal_time_slots = TimeSlot.order('start_time DESC').where(status: "Current").where(minutes: 60)

    # Else it is a request for a user to select a time slot  
    # Also could do, if type is vacant-appts then for user to select an appointment time
    # elsif params[:type] = "vacant-appts"
    else
      
      # Set appointment to user's appointment in registration
      appointment = current_user.appointment_in_registration

      # Set duration to the duration of the appointment or default to 60
      duration = appointment.duration || 60

      # Get all time slots that fit criteria
      # Must be "Current", vacant, correct duration
      # and not start within 2 day buffer unless nitko for now
      if current_user.email == "d.nitko@comcast.net"
        day_buffer = 0
      else
        day_buffer = 0 
      end

      @time_slots = TimeSlot.where(status: "Current").where(vacancy: true).where(minutes: duration).where(['start_time > ?', DateTime.now + day_buffer.days]) 
      
      # Temporary fix for only sending back Tara's schedule to clients she gives a link to and are marked as having tara_rerral as true
      if current_user.tara_referral == true
        @time_slots.to_a.delete_if do |time_slot|
          if time_slot.dietitian.email != "tara@kindrdfood.com"
            true # Make sure the if statement returns true, so it gets marked for deletion
          end
        end
      end
      
      @cal_time_slots = @time_slots.to_a.uniq{|time_slot| time_slot.start_time}
      
    end
    
    # Why do I need the dietitians?
    @dietitians = Dietitian.all
  end

  # GET /time_slots/1
  # GET /time_slots/1.json
  def show
  end

  # GET /time_slots/new
  def new
    @time_slot = TimeSlot.new
  end

  # GET /time_slots/1/edit
  def edit
  end

  # POST /time_slots
  # POST /time_slots.json
  def create

    num_create = params["number"].to_i
    ## create multiple of the same time_slot
    if num_create > 1
      new_params = time_slot_params
      for i in 1...num_create
      
       TimeSlot.new(new_params).save
      end
      @time_slot = TimeSlot.new(new_params)
    ## create single time_slot
    else
      @time_slot = TimeSlot.new(time_slot_params)
    end
    respond_to do |format|
      if @time_slot.save
        # prepare for updateding time_slots list for index in .js
        @time_slots = TimeSlot.order('start_time DESC').all
        format.html { redirect_to @time_slots, notice: 'Time slot was successfully created.' }
        format.json { render :show, status: :created, location: @time_slot }
        format.js
      else
        format.html { render :new }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_slots/1
  # PATCH/PUT /time_slots/1.json
  def update
    respond_to do |format|
      if @time_slot.update(time_slot_params)
        format.html { redirect_to @time_slot, notice: 'Time slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_slot }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # get /time_slots/:id/create_from_existing
  def create_from_existing

    #create new object with attributes of existing record 
    @time_slot = TimeSlot.new(@time_slot.attributes.except("id")) 
    @time_slot.save

    if @time_slot.save
      @time_slots = TimeSlot.order('start_time DESC').all
      respond_to do |format|
        format.js
      end
    end
  end

  # get /time_slots/create_from_availability
  # method not working
  # method name coming in as parameter and before action set time slot being claled
  def create_from_availability
    open_availabilities = Availability.where(status: "Set")
    
    @new_time_slots = TimeSlot.create_from_availabilities(open_availabilities)
    
      respond_to do |format|
        format.js
      end
  end

  # DELETE /time_slots/1
  # DELETE /time_slots/1.json
  def destroy
    @time_slot_id = @time_slot.id
    @time_slot.destroy
    respond_to do |format|
      format.html { redirect_to time_slots_url, notice: 'Time slot was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_slot
      
      @time_slot = TimeSlot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_slot_params
  
            ## switch month/day to day/month to match format for saving
        params[:time_slot][:start_time] = params[:time_slot][:start_time].gsub(%r{(.*)/(.*)/(.*)}, '\2/\1/\3') + " EST"
        params[:time_slot][:end_time] = params[:time_slot][:end_time].gsub(%r{(.*)/(.*)/(.*)}, '\2/\1/\3') + " EST"
        #       params[:time_slot][:start_time] = params[:time_slot][:start_time] + " EST"
        # params[:time_slot][:end_time] = params[:time_slot][:end_time] + " EST"

      params.require(:time_slot).permit(:title, :start_time, :end_time, :vacancy, :minutes, :status, :availability_id)
    end
end
