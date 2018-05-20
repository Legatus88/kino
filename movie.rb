require 'csv'
require 'money'
require 'virtus'

class Movie
  
  include Virtus.model
  
  attribute :my_hash, Hash
  attribute :link, String
  attribute :title, String
  attribute :year, Integer
  attribute :country, String
  attribute :starting_date, String
  attribute :genre, String
  attribute :time, Integer
  attribute :rate, Float
  attribute :producer, String
  attribute :actors, String
  attribute :col, Object
 
  def initialize(hash={}, collection)
    @col = collection
    @my_hash = my_hash
    @link = hash[:link]
    @title = hash[:title]
    @year = hash[:year].to_i
    @country = hash[:country]
    @starting_date = hash[:starting_date]
    @genre = hash[:genre].split(',')
    @time = hash[:time].to_i
    @rate = hash[:rate].to_f
    @producer = hash[:producer]
    @actors = hash[:actors].split(',')
  end
  
  def self.create(line, list)
    case line[:year].to_i
    when 1900..1945
      AncientMovie.new(line, list)
    when 1945..1968
      ClassicMovie.new(line, list)
    when 1968..2000
      ModernMovie.new(line, list)
    when 2000..Time.now.year.to_i
      NewMovie.new(line, list) 
    end
  end
  
  def period
    self.class.to_s.chomp('Movie').downcase.to_sym
  end

  def matches?(key, value)
    if key.to_s.start_with?('exclude_')
      new_key = key.to_s.sub('exclude_', '')
      return Array(send(new_key)).any?{|cell| cell != value}
    end
    Array(send(key)).any?{|cell| Array(value).any?{|v| v === cell}}
  end

  def has_genre?(param)
    col.genre_list.include?(param) or raise ArgumentError, 'Sorry, this GENRE doesn\'t exist'
    genre.include?(param)
  end

  def price
    self.class::COST
  end

  def id_sym
    @link.split('/')[4].to_sym 
  end

  def poster
    YAML.load(File.read('./poster.yml'))[id_sym].first
  end

  def ru_title
    YAML.load(File.read('./ru_title.yml'))[id_sym].first
  end

  def budget
    YAML.load(File.read('./budget.yml'))[id_sym].first
  end
end
