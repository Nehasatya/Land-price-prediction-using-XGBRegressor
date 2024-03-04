# require 'pycall/import'
# include PyCall::Import
# pyfrom :'sklearn.model_selection', import: :train_test_split
# PyCall.import_module("pandas")
# PyCall.import_module("numpy")
class InputController < ApplicationController

  def index
  end

  def new
    @input = Input.new
  end

  def info

    @input = Input.new(input_params)

    if @input.valid?
      # Ml.predict_prices(@input)
      @input.save
      redirect_to @input, notice: 'Successfully created'
    else
      render new
    end
  end

  private

  def input_params
    params.require(:input)
          .permit(
            :city,
            :area,
            :bedrooms,
            :bathrooms,
            :preference,
            :property_type
          )
  end
end
