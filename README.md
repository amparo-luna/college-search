# College Search application

This application implements a college search feature that connects with the [College Scorecard API](https://collegescorecard.ed.gov/).
Users have the ability to search for any college name in the search box adn the results will be displayed next to the map.

Clicking on a particular result will center the map and place a marker on the school's location received from the College Scorecard API.

If the location data is not available from the College Scorecard API result, clicking on the result does not do anything and a JS error is log to the console.

## Live test site

You can check this app live in this [Heroku app](https://al-college-search-6e6ba0f19e33.herokuapp.com).

## Local setup

To run this application locally:

1. Clone the repo
```
git clone git@github.com:amparo-luna/college-search.git
```
2. To setup the app, run
```
`./bin/setup`
```
3. Run the test suite with
```
./bin/rails test:all
```
4. Set up api keys:
    - To use your own College Scorecard api key and Google Maps key, please remove the `config/credentials.yml.enc` file from the branch and recreate the credentials file. Once you save and exit the editor `config/master.key` and `config/credentials.yml.enc` files will be generated.
        ```
          # you can change vim here for your preferred one if you'd like
          EDITOR="vim" ./bin/rails credentials:edit

          # inside the editor add the keys like this
          college_score_card:
            api_key: <your_college_scorecard_key>

          google_maps:
            api_key: <your_google_maps_key>
        ```

    - If you don't have those, use the master key provided via email. Copy and paste it on the `config` folder
5. Start the rails server
```
./bin/rails server
```

## Additional comments
### Further improvements
- Search result pagination as the app is only displaying the first 20 results for this first implementation.
- Clickable marker to display extra information about the college.


