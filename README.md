# README

### BattleShift

#### Description

This project builds on top of a pre-existing API implementation of the game Battleship. The prior project allowed a player to play against a computer through an API. For this project we added multiplayer functionality, basic levels of security (authentication and email confirmation) and refactored code to eliminate technical debt.



#### Rails version: 5.1.6

### Configuration

* Clone the repository:
```
git clone https://github.com/SSchwartz214/battleshift.git
```

* To install gems:
```
$ bundle install
$ bundle update
```
##### Special gem notes:
Figaro

To install:
$ bundle exec figaro install

This creates a commented config/application.yml file and adds it to your .gitignore. Add your own configuration to this file and you're done!

* To create and seed database:
```
$ rake db:{create,migrate,seed}
```

* How to run the test suite
```
$ rspec
```

* To view production version, visit:
```
https://warm-beyond-14406.herokuapp.com/
```


#### Questions or comments?

Please contact us at:

* Tristan: https://github.com/TristanB17
* Seth: https://github.com/SSchwartz214
