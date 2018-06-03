require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require 'progress_bar'
require_relative './budget_downloader.rb'
require_relative './tmdb_downloader.rb'  
require_relative '../movie_collection.rb'

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

    def test
      puts 'tralala'
    end
  end
end
