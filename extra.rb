require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'

module Extra
  def data_tmdb
    @tmdb ||= YAML.load(File.read('./title_and_poster.yml'))
  end

  def data_budget
    @budget ||= YAML.load(File.read('./budget.yml'))  	
  end

  class BudgetDownloader
  end

  class TMDBDownloader
  end  
end