require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'


class BudgetDownloader
  
  def initialize(collection)
    @collection = collection
    @big_hash = {}
  end

  # открытие страницы
  def page_open(link)
    html = open(link, :allow_redirections => :safe) # только так удалось выполнить редирект
    Nokogiri::HTML(html)
  end

  # сохранялка на хард
  def page_download(link)
    File.write('./page.html', page_open(link))
  end

  def open_from_hard(movie)
    page_download(movie.link)
    Nokogiri::HTML(File.read('page.html'))
  end

  def download_for(movie)
    hard = open_from_hard(movie)
    id_key = movie.link.split('/')[4].to_sym

    all_h4 = hard.css('div.txt-block h4')
    wanted_h4 = all_h4.select{|h4| h4.text.eql? 'Budget:'}.first
    
    if !wanted_h4.nil?
      div_number = all_h4.index(wanted_h4)
      wanted_div = hard.css('div.txt-block')[div_number] 
      @big_hash[id_key] = [wanted_div.text.strip.split(' ').first.sub(/^Budget:/, '')]
    else
      @big_hash[id_key] = ['Unknown']
    end
  end

  def download
    bar = ProgressBar.new(@collection.all.length)
    @collection.each do |movie| 
      download_for(movie)
      bar.increment!
    end    
    Saver.new(@big_hash)  
  end
end

# зачем скачивать страницу на хард?
# мы по времени выигрываем? или по ресурсам?
