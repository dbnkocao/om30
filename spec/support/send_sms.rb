RSpec.configure do |config|
  config.before(:each) do
    SendSms.any_instance.stub(:call).and_return(true)
  end
end
