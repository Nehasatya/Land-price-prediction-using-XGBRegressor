print "=> In Estimator\n"
require 'pycall/import'
require 'pandas'
require 'debug'
require 'daru'
include PyCall::Import
class Ml::Estimator
  def initialize
    @pipeline = initialize_pipeline
    print "=>==> @pipeline - #{@pipeline}\n"
    @estimator = initialize_estimator
    print "=>==> @estimator - #{@estimator}\n"
  end

  def predict(balcony, bedroom, city, total_floor)
    print "=>==> In predict\n"
    # print "=>==> @pipeline - #{@pipeline}\n"
    data = {
      'BALCONY_NUM' => [balcony],
      'BEDROOM_NUM' => [bedroom],
      'CITY'=> [city],
      'TOTAL_FLOOR'=> [total_floor]
    }

    print "=>==> Before\n"

    pipeline_input_data =  Daru::DataFrame.new(
      {'BALCONY_NUM' => [balcony],
        'BEDROOM_NUM' => [bedroom],
        'CITY' => [city],
        'TOTAL_FLOOR' => [total_floor] }, index: [0]
    )
    print "=>==> pipeline_input_data - #{pipeline_input_data}\nshape - #{pipeline_input_data.shape}\n"
    reshaped_data = pipeline_input_data.map_rows { |row| row.to_a }
    print "=>==> pipeline - #{@pipeline}\n"
    print "=>==> reshaped_data - #{reshaped_data}\n"
    prepared = @pipeline.transform(reshaped_data)
    print "=>==> prepared input pipeline- #{prepared}\n #{prepared.shape}\n"
    predicted = @estimator.predict(prepared)
    print "=>==> predicted - #{predicted}\n"
    # @all_periods.each_with_index
    #             .each_with_object({}) { |(period, idx), result| result[period] = predicted[idx] }
    return predicted[0]
  end

  def initialize_pipeline
    pickle = PyCall.import_module("pickle")
    print "===> [PIPELINE] Initializing\n"
    pipeline_pkl = open("./ML/idx_pipeline.pickle", "rb")
    loaded = pickle.load(pipeline_pkl)
    print "===> [PIPELINE] Finished initializing\n"
    loaded
  end

  def initialize_estimator
    pickle = PyCall.import_module("pickle")
    print "===> [ESTIMATOR] Initializing\n"
    estimator_pkl = open("./ML/model.pkl", "rb")
    loaded = pickle.load(estimator_pkl)
    print "===> [ESTIMATOR] Finished initializing\n"
    loaded
  end
end