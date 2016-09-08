Craigslust
==========

The craigslust project was created in order to learn more about working with data. It is part experiment and part work-in-progress. 

It is a Sinatra application that scrapes data from the missed connections forum on Craigslist, and then reveals statistics and information about those posts. 

## TODOS:
1. Improve performace (incredibly slow)
2. Remove duplicate code between NYC and PDX 
3. Use Google Chart API (JS) in place of Google_Visualr gem
4. The naming of things!
5. Deploy

to run the app locally:
After running bundle, you should be able to start the app with `bundle exec rackup -p 5000` and navigate to localhost:5000

to open a console:
type `irb` in the root directory, and then `require './app.rb'`

to run the specs:
type `bundle exec rspec` from the root directory