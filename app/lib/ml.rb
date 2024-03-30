class Ml
  def self.estimate_prices(property)
    print "=>===> In estimate_prices\n"
    print "=>==> Going to predict\n"
    print "=>==> estimator - #{estimator}\n"
    # print "=>==> estimator pipeline - #{estimator.pipeline}" w
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
    print "=>==> @@estimator1 - #{@@estimator}"
    @@estimator
  end

  def self.estimator=(estimator)
    print "=>==> @@estimator2 - #{estimator}"
    @@estimator = estimator
  end
end