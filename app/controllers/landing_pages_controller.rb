class LandingPagesController < ApplicationController
  before_action :get_new_user
  # home landing page
  def index
  end

  # qol admin landing page
  def qol_admin
  end

# qol direct sign up landing page
  def qol
  end

# tara referral landing page
  def tara
  end

# /join redirects to /tara referral landing page
  # def join
  #   
  # end

  def our_solution
  end

  def results
  end

  def how_it_works
  end

  def who_we_help
  end

  def why_kindrdfood
  end

  def quality
  end

  def navigate_change
  end

  def our_mission
  end

  def leaders
  end

  def benefits
  end

  def more_benefits
  end

  def care
  end

  def refer
  end

  private

  def get_new_user
    @user = User.new 
  end
end
