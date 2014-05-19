require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base
  get '/' do
    erb :index
  end

  run! if app_file == $0
end

