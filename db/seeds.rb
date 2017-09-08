# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Url.delete_all
mechanize = Mechanize.new
page = mechanize.get('http://en.wikipedia.org/wiki/Main_Page/')
# We will follow random articles from wikipedia 10 000 times
1000.times do
  u = Url.new
  link = page.link_with(text: 'Random article')
  page = link.click
  u.process_url(page.uri)
  puts "Going to save #{u.url}"
  result = u.save ? "Saved successfully" : "Some error happened"
  p result
end