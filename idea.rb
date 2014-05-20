require 'yaml/store'
class Idea
  attr_reader :title, :description, :type, :type_name

  def initialize(title, description, type='default', type_name)
    @title = title
    @description = description
    @type = type
    @type_name = type_name
  end

  def type_list(set_type)
    case set_type
      when "primary"
        'work'
      when "info"
        'life'
      when "success"
        'health'
      when "warning"
        'read'
      when "danger"
        'action'
      #when 'default'
    end
  end

  def self.all
    raw_ideas.map do |data|
      new(data[:title], data[:description], data[:type], data[:type_name] )
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {title: @title, description: @description, type: @type , type_name: type_list(@type)}
    end  
  end

  def self.database
    @database ||= YAML::Store.new "ideabox"
  end
  def database
    Idea.database
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    new(raw_idea[:title], raw_idea[:description])
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

end

