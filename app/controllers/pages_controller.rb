class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home; end

  def kitchensink; end

  def test; end

end
