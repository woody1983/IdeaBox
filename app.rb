require 'bundler'
require './idea'

Bundler.require


class IdeaBoxApp < Sinatra::Base
 
  configure :development do
    register Sinatra::Reloader
  end #For Automatic Reloading

set :method_override, true
set :public_folder, File.dirname(__FILE__) + '/static'

  not_found do
    erb :error
  end


  get '/' do
    erb :index, locals: {ideas: Idea.all}
  end

  post '/' do
    type_idea =  params['idea_type']
    idea = Idea.new(params['idea_title'],params['idea_description'],type_idea,params['idea_type'])
    idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

end

