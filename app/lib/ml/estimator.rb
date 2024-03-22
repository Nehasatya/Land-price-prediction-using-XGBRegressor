print "=> In Estimator\n"
require 'pycall/import'
print "=> Pycall require #{require 'pycall/import'}"
print "=> In Estimator after loading pycall"
include PyCall::Import

pd = PyCall.import_module("pandas")
np = PyCall.import_module("numpy")

class Ml::Estimator
  def initialize
    @pipeline = initialize_pipeline
    @estimator = initialize_estimator
  end

  def predict(balcony, bedroom, city, total_floor)
    print "=>==> In predict\n"

    data = {
      'BALCONY_NUM': [balcony],
      'BEDROOM_NUM': [bedroom],
      'TOTAL_FLOOR': [total_floor],
      'CITY': [city]
    }
    print "=>==> data - #{data}\n"
    pd = PyCall.import_module("pandas")
    df = pd.DataFrame(data, columns: ['BALCONY_NUM', 'BEDROOM_NUM', 'TOTAL_FLOOR', 'CITY'])
    print "=>==> df - #{df}\n"
    print "=>==> "
    prepared = @pipeline.fit_transform(df)
    print "=>==> prepared input pipeline\n"
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