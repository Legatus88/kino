Gem::Specification.new do |s|
  s.files = Dir['lib/   *.rb'] + Dir['bin/*']
  s.name = 'kino'
  s.summary = 'Educational project'
  s.version = '0.0.1'
  s.authod = 'Kirill Baranenkov'
  s.description = <<-E0F
    kino is a little program implemented in ruby. Tasks and
    dependencies are specified in standard Ruby syntax.
  E0F
  s.email = 'y1wkn8@gmail.com'
  s.homepage = 'https://github.com/Legatus88/kino'
  s.license = 'MIT'
  s.bindir = 'bin'
  s.executables << 'netflix_exe.rb'
  s.post_install_message = "Thanks for installing!"
  s.required_ruby_version = '>= 2.0'
end