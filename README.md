# Weather – Ruby on Rails application

Create a Ruby on Rails application from scratch. Integrate the OpenWeatherMap 5 days/3
hour forecast API method. Gather data from 3 cities: Tallinn, Tartu and Brno. Store and display the data. 

## FEATURES

### User Authentication
Users are created and authenticated passively using cookies. A randomly generated base64 string is stored in cookie, if no cookie is found a new User is created and a cookie is set. New Users are saved with five default locations.

### Saved Locations
Locations are saved to the database and belong to a User. Adding and removing locations is done using the ToggleLocation React component.

### API Interface
All data is fetched via ajax requests to the Rails server, which uses HTTParty gem to retrieve weather data via the Wunderground API. A valid Wunderground API key is required and must be stored in ENV["API_KEY"].

### Autocomplete
Autocomplete also interfaces with a Wunderground API, but does not require a key. Results are retrieved and the top 5 are displayed in a dropdown.

### ToggleLocation
This component determines if the current location is saved in the User's list, and provides the correct Add/Remove action accordingly. This requires the use of the LocationUtil.convertLocation method to convert the location object received from the API into an object that can be compared the the locations saved in the database and LocationsStore.

### Install the Required Gems

If you used the "Rails Composer":http://railsapps.github.io/rails-composer/ tool to generate the example app, the application template script has already run the @bundle install@ command.

If not, you should run the @bundle install@ command to install the required gems on your computer:

<pre>
> $ bundle install
</pre>

You can check which gems are installed on your computer with:

<pre>
$ gem list
</pre>

Keep in mind that you have installed these gems locally. When you deploy the app to another server, the same gems (and versions) must be available.

### Set the Database

Prepare the database and add the default user to the database by running the commands:

<pre>
$ rake db:migrate
$ rake db:seed
</pre>

Use @rake db:reset@ if you want to empty and reseed the database.

## Test the App

You can check that your application runs properly by entering the command:

<pre>
$ rails server
</pre>

To see your application in action, open a browser window and navigate to "http://localhost:3000/"

You should see a home page with a navigation bar.

Click the "Sign up" and create new user.

You'll see a page with a form that is used to register a new account.

Click the "Sign in" and login with admin user.

> Username: admin@admin.com

> Password: admin123

You'll see a page with users.

### RSpec Test Suite

The application contains a suite of RSpec tests. To run:

<pre>
$ rspec
</pre>
