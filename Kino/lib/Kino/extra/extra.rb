require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require '../cinema/movie_collection'
require 'progress_bar'
require './budget_downloader'

module Kino
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
end
