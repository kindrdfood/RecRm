# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  question_type   :string(255)
#  content         :text
#  position        :integer
#  choices         :text
#  tier            :integer          default(1)
#  created_at      :datetime
#  updated_at      :datetime
#  survey_group_id :integer
#

module QuestionsHelper
end
