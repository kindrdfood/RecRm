# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  surveyable_id   :integer
#  surveyable_type :string(255)
#  completed       :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  survey_group_id :integer
#  last_updated_at :datetime
#  completed_at    :datetime
#

class SurveysController < ApplicationController
  before_filter :load_surveyable, only: [:index, :new, :edit, :create, :show]
  before_action :set_survey, only: [:edit, :update, :show]
  include PatientGroupsHelper

  def index
    @surveys = @surveyable.surveys
  end

  def show

    @survey_group = @survey.survey_group.name
    respond_to do |format|
      format.js 
      format.html
    end

  end

  def new
    
    if params[:survey_type] == "Pre-Appointment-Dietitian"
      @survey = Survey.generate_for_appointment(@surveyable, current_dietitian)
    end
    
    # @survey = @surveyable.surveys.new
    respond_to do |format|
      format.js 
    end
  end
    
  def create
    @survey = @surveyable.surveys.new(params[:survey])
    if @survey.save
      redirect_to @surveyable, notice: "survey created."
    else
      render :new
    end
  end

  def edit

    @survey_group = @survey.survey_group.name

    respond_to do |format|
      format.js 
      format.html
    end
  end

  def update
    
    update_questions_with_answers(params[:questions])
    
    respond_to do |format|
      if @survey.update(survey_params)

        if current_user 
          format.html { redirect_to welcome_home_path, notice: 'Updated!' }
          format.json { render :show, status: :ok, location: @survey }
          format.js  {flash.now[:notice] = "Updated!"}
        else
          format.html { redirect_to dietitian_authenticated_root_path, notice: 'Updated!' }
          format.json { render :show, status: :ok, location: @survey }
          format.js {flash.now[:notice] = "Updated!"}
        end
        
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def update_questions_with_answers(questions_hash)

    ## save each question with the answer
    questions_hash.each do |question_id, answer|
      question = SurveysQuestion.find(question_id.to_i)
      question.answer = answer
      question.save
    end
  end

  def load_surveyable
    klass = [Appointment, User, PatientGroup].detect { |c| params["#{c.name.underscore}_id"]}
    @surveyable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      
      params.require(:survey).permit(:completed)
      # params.require(:survey).permit(:completed, :survey_type, :surveyable_id, :surveyable_type )
    end

end
