# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # table is:
    # title                   | rating | release_date |
    Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{e1}.*#{e2}/m
end

Given /I should see the following in order: \"(.+)\"/ do |movie_list|
  movie_titles = movie_list.split(',')
  previous_title = nil
  movie_titles.each do |movie_title|
    if previous_title == nil
      previous_title = movie_title
    else
      page.body.should =~ /#{previous_title}.*#{movie_title}/m
      previous_title = movie_title
    end
  end
end

When /I (un)?check the following ratings: (.*)/ do |un, rating_list|
  rating_list.split(',').map(&:strip).each do |rating|
      step "I #{un}check \"#{rating}\""
  end
end

When /I (un)?check all ratings/ do |un|
  Movie.all_ratings.each do |rating|
    step "I #{un}check \"#{rating}\""
  end
end
