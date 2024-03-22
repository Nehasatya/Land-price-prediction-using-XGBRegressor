class Ml
  def self.estimate_prices(property)
    print "=>===> In estimate_prices\n"
    print "=>==> Going to predict\n"
    print "=>==> estimator - #{estimator}\n"
    predictions =
      estimator.predict(
        property.balcony_num,
        property.bedroom_num,
        property.city,
        property.total_floor
      )
    print "=>==> After prediction #{predictions}\n"
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