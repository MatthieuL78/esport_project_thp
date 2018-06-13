# Esport - Player & Sponsor

This project is the first version of our Esport application created with Ruby on Rails. The goal of this application is to make an easy connection between Esport Players, teams and sponsors. It will be a simple tool to use for the team and sponsor to see the evolution of the esport scene by game. In this first version we just use the following 4 mains models :

* Player

* Sponsor

* Game

* Event

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You need the following version of Ruby and Ruby on Rails to use the application on local :

```
ruby '2.5.1'
Rails '5.2.0'
```

### Installing

Fork the project from the github and launch the bundle as following :

```
bundle install --without production
```

You can launch the project in development : 

```
rails s
```

Or in production :

```
rails s -e production
```

Then you can create an account, or login as 'Player' or 'Sponsor' in the path /players/sign_in, /sponsors/sign_in, /players/sign_up and /sponsors/sign_up. You can watch the top 10 players for each game in your database in the path /classement/ranking. You can watch the different past / current / futur events in the root. 

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Geraldy1st** - *Front end* - (https://github.com/geraldy1st)
* **Thomas Szadek** - *Front end* - (https://github.com/thomisz)
* **MatthieuL78** - *Back end* - (https://github.com/MatthieuL78/)

## License

This project is licensed under the THP License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
