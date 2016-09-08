Craigslust
==========

Slowly refactoring this project I started while learning to code in 2013.

It was created in order to learn more about working with data; part experiment, part work-in-progress.

It is a Sinatra application that scrapes data from the missed connections forum on Craigslist, and then reveals statistics and information about those posts.

To run the app locally:
After running `bundle install`, you should be able to start the app with `bundle exec rackup -p 5000` and navigate to localhost:5000

To open a console:
Open `irb` in the root directory, and then `require './app.rb'`

To run the specs:
Run `bundle exec rspec` from the root directory
