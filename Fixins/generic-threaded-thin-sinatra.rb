
Thread.new {
  Thin::Server.start('0.0.0.0', 3333, Class.new(Sinatra::Base) {
                                get '/logs' do
                                  ret = {}
                                  ret[:foo] = 'bar'
                                  ret[:baz] = 'too'
                                  ret.to_json

                                end

                                post '/logs'
                                ret = {}
                                @logs = JSON.parse(params[:logfile], :symbolize_names => true)

                                ret[:foo] = 'success'

                              })}
