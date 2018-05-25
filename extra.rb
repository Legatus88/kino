require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'

# module for loading yaml files
module Extra
  def data_tmdb
    @data_tmdb ||= YAML.safe_load(File.read('./title_and_poster.yml'))
  end

  def data_budget
    @data_budget ||= YAML.safe_load(File.read('./budget.yml'))
  end

  class BudgetDownloader
  end

  class TMDBDownloader
  end
end
