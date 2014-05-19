require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end #For Automatic Reloading

  get '/' do
    erb :index
  end

end

