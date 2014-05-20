require 'yaml/store'
class Idea
  attr_reader :title, :description, :type, :type_name

  def initialize(title, description, type, type_name)
    @title = title
    @description = description
    @type = type
    #@type_name = type_list[@type]
    @type_name = type_name
  end

  def type_list(set_type)
    #pre_type_list = {primary:'work',info:'life'}
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
      db['ideas'] << {title: @title, description: @description, type: @type, type_name: type_list(@type)}
    end  
  end

  def self.database
    @database ||= YAML::Store.new "ideabox"
  end
  def database
    Idea.database
  end


end

