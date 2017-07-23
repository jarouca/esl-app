# E-Flash
![Build Status](https://codeship.com/projects/d95d8eb0-5169-0135-490e-1e8d7c96cf79/status?branch=master)
![Code Climate](https://codeclimate.com/github/jarouca/esl-app.png)
![Coverage Status](https://coveralls.io/repos/jarouca/esl-app/badge.png)

E-Flash is an educational Rails app designed to help learners of English as a second language expand their vocabulary. Users are able to create customized vocabulary word banks and then 'flash card' drill those words to practice learning parts of speech and definitions. An integrated external API helps users retrieve definitions and parts of speech for words. AJAX implementation helps to make for a seamless, smoother user experience as words are defined, added to the word bank and then 'drilled'. 

This project uses the following libraries and frameworks:

- Ruby on Rails
- Javascript
- AJAX
- HTTParty

## Demo

For a live demo of the app, please visit: [E-Flash](https://esl-app.herokuapp.com/)

## Setup

This app uses Ruby 2.2.5 and was developed on Ruby on Rails 5.0.3. 

To install, please run the following in your terminal: 

### Set up Rails

```
git clone https://github.com/jarouca/esl-app.git
cd esl
bundle install
rake db:create
rake db:migrate
```

## Running the application

To run E-Flash, please run the following command in your terminal from the esl directory:

`rails s`

Now open your browser and enter localhost:3000 in your address bar.

## Testing

To run the test suite, please enter the following command from the esl root directory:

`rspec`




