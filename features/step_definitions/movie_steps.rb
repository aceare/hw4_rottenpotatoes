# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    puts "creating movie #{movie}"
    Movie.create!(movie)
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /^(?:|I )should see "([^"]*)" before "([^"]*)"$/ do |earlier, later|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#p  page.body
#p "earlier #{earlier} later #{later}"
#p  page.body.match("#{earlier}(?xm:.*)#{later}")
#p  page.body.match("Chocolat(?xm:.*)Amelie")
#p  page.body.match("Chocolat")
assert page.body.match("#{earlier}(?xm:.*)#{later}") != nil

#e1,e2="maza desh","maze bandhav"
#s="bharat maza desh aahe. sare \nbharatiya maze bandhav aahet"
##s="bharatmazadeshaahesarebharatiyamazebandhavaahet"
#p s.match("maz")
#p s.match(/maza desh(?xm:.*)maze bandhav/)
#p s.match("#{e1}(?xm:.*)#{e2}")
##  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s/).each do |rating| uncheck ? uncheck("ratings_#{rating}") : check("ratings_#{rating}") end
end


When /I (un)?check all the ratings/ do |uncheck|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
#  p "uncheck = #{uncheck}"
  ["G", "PG", "PG-13", "NC-17", "R"].each do |rating| uncheck ? uncheck("ratings_#{rating}") : check("ratings_#{rating}")
  end
#  check("ratings_NC-17")
  click_button('Refresh')
#  p "done refresh"
end


Then /I should not see any of the movies/ do
#  page.has_table?("movies tr", :count => 1)
#  page.find('table#myTable').find(:row, 3).text
#  p "***** table row count #{page.find('table#movies tr').count}"
#  page.all('table#movies tr').count.should == 10
#  page.should have_css("table#movies tr", :count=>10)

#OK  p "table row count #{page.all('table#movies tr').count}"
#OK  p "table row count #{page.all('table#movies tbody tr').count}"
#p "table row count #{page.all('table#movies tbody tr').count}"
#                     page.all('table#movies tbody tr').count == 0
#  assert page.all('table#movies tbody tr', :count => 0)
  assert page.all('table#movies tbody tr').count == 0
end

Then /I should see all of the movies/ do
#p "table row count #{page.all('table#movies tbody tr').count}"
#                     page.all('table#movies tbody tr').count == 10
  tot = Movie.all.count
#  assert page.all('table#movies tbody tr', :count => tot)
  assert page.all('table#movies tbody tr').count == tot
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  assert page.body.match("Details about #{title}(?xm:.*)Director:(?xm:.*)#{director}") != nil
end

