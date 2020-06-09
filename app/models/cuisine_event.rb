class CuisineEvent < ApplicationRecord
  belongs_to :events
  belongs_to :cuisenes

  def create
    # raise
  @event = event.find(params[:cocktail_id])
  @cuisine = Cuisine.find(params[:cuisine_event][:cuisine_id])
  @dose = Dose.new(dose_params)
  @dose.ingredient = @ingredient
  @dose.cocktail = @cocktail
    if @dose.save!
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

end
