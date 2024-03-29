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

    data = {
      'BALCONY_NUM' => [balcony],
      'BEDROOM_NUM' => [bedroom],
      'CITY'=> [city],
      'TOTAL_FLOOR'=> [total_floor]
    }
    # df = Pandas.DataFrame(data)
    # df_city = Pandas.DataFrame(city)
    # prepared = @pipeline.fit_transform(Pandas.concat([df, df_city]))
    # print "=>==> data - #{data}\n"
    print "=>==> After importing pandas\n"
    # pd = PyCall.import_module("pandas")
    print "=>==> Before\n"
    # print" pd.DataFrame - #{Pandas.DataFrame}\n"
    # df = Pandas()
    df = Pandas::DataFrame
    pipeline_input_data =  Daru::DataFrame.new(
      {'BALCONY_NUM' => [balcony],
        'BEDROOM_NUM' => [bedroom],
        'CITY' => [city],
        'TOTAL_FLOOR' => [total_floor] }, index: [0]
    )
    # pipeline_input_data = [[balcony],[bedroom],[city],[total_floor]]
    # print "=>==> df - #{df}\n"
    print "=>==> prepared input pipeline- #{pipeline_input_data}\n#{pipeline_input_data.shape}\n"
    # print "=>==> prepared input pipeline- #{prepared}\n #{prepared.shape}\n"
    prepared = @pipeline.transform(pipeline_input_data[0])
    print "=>==> prepared input pipeline- #{prepared}\n #{prepared.shape}\n"
    predicted = @estimator.predict(prepared)
    print "=>==> predicted - #{predicted}\n"
    # @all_periods.each_with_index
    #             .each_with_object({}) { |(period, idx), result| result[period] = predicted[idx] }
    return predicted
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