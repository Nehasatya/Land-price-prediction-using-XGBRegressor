class PropertyController < ApplicationController

  def index
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create

    @property = Property.new(property_params)

    if @property.valid?
      print "=>==> In create\n"
      @property = Ml.estimate_prices(@property)
      print "=>==> Executed estimate price\n"
      @property.save
      redirect_to @property, notice: 'Successfully created'
    else
      render new
    end
  end

  private

  def property_params
    params.require(:property)
          .permit(
            :balcony_num,
            :bedroom_num,
            :city,
            :total_floor
          )
  end
end
