# require 'pycall/import'
# include PyCall::Import
# pyfrom :'sklearn.model_selection', import: :train_test_split
# PyCall.import_module("pandas")
# PyCall.import_module("numpy")
class PropertyController < ApplicationController

  def index
  end

  def new
    @property = Property.new
  end

  def create

    @property = Property.new(property_params)

    if @property.valid?
      Ml.estimate_prices(@property)
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
