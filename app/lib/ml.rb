class Ml
  def self.estimate_prices(property)
    predictions =
      estimator.predict(
        property.balcony_num,
        property.bedroom_num,
        property.city,
        property.total_floor
      )

    property.price = predictions

    property
  end


  def self.estimator
    @@estimator
  end

  def self.estimator=(estimator)
    @@estimator = estimator
  end
end