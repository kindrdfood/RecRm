class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :select_time, :destroy]
  before_filter :config_opentok,:except => [:index, :show, :new, :edit, :create, :destroy, :select_time]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
    @appointments_no_dietitian = Appointment.where(dietitian_id: nil)
    @upcoming_appointments = Appointment.where("start_time > ?", DateTime.now).order('start_time ASC, created_at ASC')
    @previous_appointments = Appointment.where("start_time < ?", DateTime.now).order('start_time ASC, created_at ASC')
    @dietitians = Dietitian.all
  end

  def select_time
    @time_slots = TimeSlot.all
    @sign_up_stage = @appointment.stage 
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @dietitians = Dietitian.all
    # @surveyable = @appointment
    # @surveys = @surveyable.surveys
    # @survey = Survey.new
    respond_to do |format|
      format.js
    end
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
    ## for first sign up from select time
    respond_to do |format|
      format.js
    end
  end

  # POST /appointments
  # POST /appointments.json
  def create

    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    
    # if update saves
    if @appointment.update(appointment_params)
      # if stripe card payment update incnluded in update then user is paying 
      if appointment_params[:stripe_card_token]
        # pay for appointment
        token = appointment_params[:stripe_card_token]
    
        # check if credit card should be saved to stripe account
        credit_card_usage = params[:credit_card_usage]
    
        @appointment.update_with_payment(credit_card_usage)
        time_slot = TimeSlot.find(params[:time_slot_id])
        time_slot.vacancy = false
        time_slot.status = "Appointment"
        time_slot.appointment = @appointment
        time_slot.save
        
        TimeSlot.cancel_related_time_slots(time_slot) 
        @pre_appt_survey = Survey.generate_for_appointment(@appointment, current_user)
        
      # or has recently been updated with dietitian thhen admin assigned dietitian
      elsif @appointment.dietitian_id != nil
        
        @new_session = @opentok.create_session 
        @tok_token = @new_session.generate_token :session_id =>@new_session.session_id 
        ## creating a new room each time, should either purge old rooms or assign rooms to dietitians 
        @new_room = Room.new(dietitian_id:  @appointment.dietitian_id, public: true, sessionId: @new_session.session_id, name: "Early Access Session")
        # @new_room = Room.new(dietitian_id:  @appointment.dietitian_id, public: true, name: "Early Access Session")
        @new_room.save
        dietitian = @appointment.dietitian
        dietitian.add_role "Session Host", @new_room
        user = @appointment.appointment_host
        user.add_role "Session Guest", @new_room
        user.save
        # set appointment to room (1st and only for now)
        if @appointment.room_id == nil
          @appointment.room_id = @new_room.id
        end
      # other updates that could happen
      else
      end
    end
    respond_to do |format|
      if @appointment.save
        if current_dietitian 
          format.html { redirect_to appointments_path(current_dietitian), notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :ok, location: @appointment }
          format.js
        else
          format.html { redirect_to user_dashboard_path, notice: 'Appointment was successfully created.' }
          format.json { render :show, status: :ok, location: @appointment }
          format.js
        end
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:patient_focus_id, :appointment_host_id, :dietitian_id, :start_time, :end_time, :room_id, :note, :client_note, :other_note, :created_at, :updated_at, :status, :time_slot_id, :stripe_card_token)
    end
  
    def config_opentok
      
      if @opentok.nil?
       @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
      end
    end
end
