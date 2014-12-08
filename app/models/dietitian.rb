class Dietitian < ActiveRecord::Base
  rolify :role_cname => 'Role'
  scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :appointments
  has_many :marketing_items
  has_many :quality_reviews
  has_many :articles
  has_many :recipes
  has_many :review_conflicts
  has_many :content_quotas
  has_many :availabilities
  has_many :time_slots, through: :availabilities
  has_many :first_reviewers, :class_name => "ReviewConflict", :foreign_key => "first_reviewer_id"
  has_many :second_reviewers, :class_name => "ReviewConflict", :foreign_key => "second_reviewer_id"
  has_many :third_reviewers, :class_name => "ReviewConflict", :foreign_key => "third_reviewer_id"
  has_many :third_reviewers, :class_name => "ReviewConflict", :foreign_key => "fourth_reviewer_id"


  def online?
    updated_at > 10.minutes.ago
  end

  def incomplete_recipes
    incomplete_recipes = []
    self.recipes.each do |recipe|
      if recipe.completed == false
        incomplete_recipes << recipe
      end
    end
    return incomplete_recipes
  end

  def incomplete_quality_reviews
    incomplete_quality_reviews = []
    self.quality_reviews.each do |quality_review|
      if quality_review.completed == false 
        incomplete_quality_reviews << quality_review
      end
    end
    return incomplete_quality_reviews
  end

  def completed_quality_reviews
    complete_quality_reviews = []
    self.quality_reviews.each do |quality_review|
      if quality_review.completed == true 
        complete_quality_reviews << quality_review
      end
    end
    return complete_quality_reviews
  end

  # def incomplete_review_conflicts
  #   incomplete_review_conflicts = []
  #   self.review_conflicts.each do |review_conflict|
  #     if review_conflict.completed == false 
  #       incomplete_review_conflicts << review_conflict
  #     end
  #   end
  #   return incomplete_review_conflicts
  # end

  # def completed_review_conflicts
  #   complete_review_conflicts = []
  #   self.review_conflicts.each do |review_conflict|
  #     if review_conflict.resolved == true 
  #       complete_review_conflicts << review_conflict
  #     end
  #   end
  #   return complete_review_conflicts
  # end

end
