class SampleApp < Sinatra::Base

  get '/' do
    erb :index
  end
end