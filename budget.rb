require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'

# зачем скачивать страницу на хард?
# мы по времени выигрываем? или по ресурсам?

class Budget
  def initialize(collection)
    @collection = collection
    @budget_hash = {}
  end

  def page_open(link)
    html = open(link, :allow_redirections => :safe) # только так удалось выполнить редирект
    Nokogiri::HTML(html)
  end

  def page_download(link)
    File.write('./page.html', page_open(link))
  end

  def add_movie_to_hash(movie)
    page_download(movie.link)
    hard_doc = Nokogiri::HTML(File.read('page.html'))

    imdb_id = movie.link.split('/')[4]
    id_key = imdb_id.to_sym
    
    all_h4 = hard_doc.css('div.txt-block h4')
    wanted_h4 = all_h4.select{|h4| h4.text.eql? 'Budget:'}.first
    
    if !wanted_h4.nil?
      div_number = all_h4.index(wanted_h4)
      wanted_div = hard_doc.css('div.txt-block')[div_number] 
      @budget_hash[id_key] = [wanted_div.text.strip.split(' ').first.sub(/^Budget:/, '')]
    else
      @budget_hash[id_key] = ['Unknown']
    end
  # возможно ли этот метод как то протестить? или для этого его нужно
  # раздробить на 2 метода? например поиск нужного заголовка и выполнение условия?
  end

  def write_to_file(path)
    bar = ProgressBar.new(@collection.all.length)
    @collection.each do |movie| 
      add_movie_to_hash(movie)
      bar.increment!
    end
    File.write(path, @budget_hash.to_yaml)    
  end
end

# можно ли каким то образом записать(добавить) этот ямл в ямл с постерами и русскими тайтлами?
# чтобы был один файл base.yml в котором будут постер, ру_тайтл, бюджет
# тогда write_to_file можно было бы вынести как модуль в отдельный файл
