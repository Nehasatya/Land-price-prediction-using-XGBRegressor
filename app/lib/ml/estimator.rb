require 'pycall/import'
# PyCall.init('C:\\Program Files (x86)\\Python')
# if require 'pycall/import'
#   puts "Package 'package_name' successfully loaded."
# else
#   puts "Failed to load package 'package_name'."
# end
include PyCall::Import
# pickle = PyCall.import_module("pickle")

class Ml::Estimator
  def initialize
    @pipeline = initialize_pipeline
    @estimator = initialize_estimator

    # @all_periods = ["Monthly", "Nightly", "Weekend night", "Weekly", "Weeknight"]
  end

  def predict(balcony, bedroom, city, total_floor)
    # all_variants = @all_periods.map { |period| [num_bed, num_bathroom, num_bedroom, num_people, city, period] }
    all_variants = [balcony,bedroom,city,total_floor]
    prepared = @pipeline.transform(all_variants)
    predicted = @estimator.predict(prepared)
    # @all_periods.each_with_index
    #             .each_with_object({}) { |(period, idx), result| result[period] = predicted[idx] }
    return predicted
  end

  def initialize_pipeline
    pyimport :pickle
    print "===> [PIPELINE] Initializing\n"
    pipeline_pkl = open("./ML/idx_pipeline.pickle", "rb")
    loaded = :pickle.load(pipeline_pkl)
    print "===> [PIPELINE] Finished initializing\n"
    loaded
  end

  def initialize_estimator
    pyimport :pickle
    print "===> [ESTIMATOR] Initializing\n"
    estimator_pkl = open("./ML/model.pkl", "rb")
    loaded = pickle.load(estimator_pkl)
    print "===> [ESTIMATOR] Finished initializing\n"
    loaded
  end
end