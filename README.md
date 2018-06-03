# kino

**kino** is an educational project.

It can be usefull in tasks like: 

* sorting movie information in txt file;
* filtering movies by selected parameters;
* watching selected movie in online cinema(or something like that)
* and much, much more!

The whole idea is: we have a .txt file with list of movies. 
We grab it and take all the information we want in rigth and pretty format.
Also we can render it in html format and watch it in very simple and comfortable
way. It has many different functions, so if you are interesting open lib.

## Showcase

```ruby
  collection = Kino::MovieCollection.new('movie.txt')
  collection.filter(genre: 'Comedy', year: 1991) # => Array, list of comedies of 1991 year
  netflix = Kino::Netflix.new('movies.txt')
  netflix.how_much?('Citizen Kane') # => 1.00, movie's price in dollars
  netflix.pay(25)
  netflix.show(period: :ancien)
```

## Usage

### Install gem

You can't install it now, cause it's bad to load study projects in public repository.

But if I did it, you would download it like this:

`gem install kino`

### Collection manipulations
 
```ruby
# Crating collection:
Kino::MovieCollection.new('movie.txt')

# Show all movies collection has:
Kino::MovieCollection.new('movie.txt').all

# Sorting by parameter
Kino::MovieCollection.new('movie.txt').sort_by(:date)

# Filtering colletcion by one or many filters:
Kino::MovieCollection.new('movie.txt').filter(country: 'USA', period: :classic)

# Returns statistics by any parameter:
Kino::MovieCollection.new('movie.txt').stats(:director)

```

### Netflix capabilities

```ruby
# Top up the balance:
Kino::Netflix.new('movie.txt').pay(20)

# Showing user's balance:
Kino::Netflix.new('movie.txt').balance

# Define user's filter:
Kino::Netflix.new('movie.txt').define_filter(:new_sci_fi) { |movie, year| movie.year &gt; year &amp;&amp; ... }

# Adding parameter to user's filter:
Kino::Netflix.new('movie.txt').show(new_sci_fi: 2010)

# Editing user's filter: 
Kino::Netflix.new('movie.txt').define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)

# Showing random movie using some filters:
Kino::Netflix.new('movie.txt').show(genre: 'Comedy')

# Getting movie's price:
Kino::Netflix.new('movie.txt').how_much?('Citizen Kane')

# Showing all movies with selected genre using DSL:
Kino::Netflix.new('movie.txt').by_genre.comedy

# Showing all movies with selected country using DSL:
Kino::Netflix.new('movie.txt').by_country.canada

# Take money from the cashbox:
Kino::Netflix.new('movie.txt').take('Bank')
```

### Theater capabilities

First of all, you need to set up the shedule like this:

```ruby
theater =
  Theater.new do
    hall :red, title: 'Красный зал', places: 100
    hall :blue, title: 'Синий зал', places: 50
    hall :green, title: 'Зелёный зал (deluxe)', places: 12

    period '09:00'..'11:00' do
      description 'Утренний сеанс'
      filters genre: 'Comedy', year: 1900..1980
      price 10
      hall :red, :blue
    end

    period '11:00'..'16:00' do
      description 'Спецпоказ'
      title 'The Terminator'
      price 50
      hall :green
    end

    period '16:00'..'20:00' do
      description 'Вечерний сеанс'
      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
      price 20
      hall :red, :blue
    end

    period '19:00'..'22:00' do
      description 'Вечерний сеанс для киноманов'
      filters year: 1900..1945, exclude_country: 'USA'
      price 30
      hall :green
    end
  end
```

Now, you can use all the capabilities ***theater*** has.


```ruby
# Check out if shedule is valid
theater.valid?

# When does theater show a movie you want:
theater.when?('Pulp Fiction')

# Buy movie ticket:
theater.buy_ticket('Citizen Kane')

# Show random movie in selected time period:
theater.show('12:00')
```

It also has some features that I didn't mention like shedule generation. Check in out in lib/theater/theater.rb if you are interested.  

### Scraping, API'ing and rendering HTML page

We can download russian title and poster path using TMDB api.

First of all, we need should create a MovieCollection.

```ruby
collection = MovieCollection.new('movies.txt')
```

Now, we can download what we want.

```ruby
# Initializing downloader
tmdb_downloader = Kino::Extra::TMDBDownloader.new(collection)

# Download title and poster for one movie:
tmdb_downloader.download_for(collection.first)

# Download title and poster for whole collection:
tmdb_downloader.load_all!

# Write all information to YAML file:
tmdb_downloader.write('./tmdb_info')

```

Next one is budget. We will get it using scraping.

```ruby
# Initializing downloader
budget_downloader = Kino::Extra::BudgerDownloader.new(collection)

# Download budget for one movie:
budget_downloader.download_for(collection.first)

# Download title and poster for whole collection:
budget_downloader.load_all!

# Write all information to YAML file:
budget_downloader.write('./budget_info')
```

Finally, we're ready for rendering all info into ***.html***

```ruby
# After writing titles, posters and budget to YAML files use this command:
Kino::write_haml('./index.html')
```

Fin!