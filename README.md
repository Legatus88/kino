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
Kino::MovieCollection.new('movie.txt').pay(20)

# Showing user's balance:
Kino::MovieCollection.new('movie.txt').balance

# Define user's filter:
Kino::MovieCollection.new('movie.txt').define_filter(:new_sci_fi) { |movie, year| movie.year &gt; year &amp;&amp; ... }

# Adding parameter to user's filter:
Kino::MovieCollection.new('movie.txt').show(new_sci_fi: 2010)

# Editing user's filter: 
Kino::MovieCollection.new('movie.txt').define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)

# Showing random movie using some filters:
Kino::MovieCollection.new('movie.txt').show(genre: 'Comedy')

# Getting movie's price:
Kino::MovieCollection.new('movie.txt').how_much?('Citizen Kane')

# Showing all movies with selected genre using DSL:
Kino::MovieCollection.new('movie.txt').by_genre.comedy

# Showing all movies with selected country using DSL:
Kino::MovieCollection.new('movie.txt').by_country.canada
```

### Theater capabilities

```ruby
# I will write them if it necesary
```

### Scraping, API'ing and rendering HTML page

```ruby
# I will write them if it necesary
```

