require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end #For Automatic Reloading

  not_found do
    erb :error
  end


  get '/' do
    erb :index,locals: {ideas: Idea.all}
  end

  post '/' do
    idea = Idea.new(params['idea_title'],params['idea_description'])
    idea.save
    redirect '/'
  end


end

