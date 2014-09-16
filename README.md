[![Build Status](https://travis-ci.org/ishakir/shakitz-fantasy-football.svg)](https://travis-ci.org/ishakir/shakitz-fantasy-football)
[![Code Climate](https://codeclimate.com/github/ishakir/footbawwl.png)](https://codeclimate.com/github/ishakir/footbawwl)

Shakitz NFL Fantasy Football for Rails
======================================

What is it?
===========

Shakitz is the open source implementation of a fantasy football league. Key features include:

* Up to 8 users
* Active and Benched players in an 18-player squad
* Ranking table for:
  * Total points
  * Head-to-head fixtures
* Player for player trades between users (under development)
* Waver wire trades for undrafted players (under development)

Shakitz had an alpha run during the 2014 preseason, and is currently in the middle of a beta run during the 2014 regular season. We hope these runs will iron out any creases making the system ready for running in full in 2015.

If you are interested in playing Shakitz NFL Fantasy Football with your friends, want to make feature requests or are interested in contributing please don't hesitate to contact either [ishakir](https://github.com/ishakir) or [MikeSpitz](https://github.com/MikeSpitz).

We're keen to drive usage and take advantage of the open source nature of the project. This is the people's fantasy system. What we believe are the most important features are listed below, let us know if you want to amend or develop some of them!

Highest Priority new features
=============================

* Complete implementation of waver wire
* Complete automation of initial player creation, fixture generation, team locking and stats updates
* Automated provisioning of production instances
* Allow points strategies
* Allow custom team sizes
* Fixtures for > 8 users
* Enhanced home page with more interesting info (team of the week, recent transfer activity etc...)
* Graphs for users points over time

Setting up a development environment
====================================

(*These instructions may be a little outdated and will be re-visited after the beta run is stable)

You will need [rails](http://rubyonrails.org/download) before you can do anything. Once you have done that:

Clone the repository:

    git clone git://github.com/ishakir/footbawwl

Change into the directory created:

    cd footbawwl

Install all the necessary gems

    (sudo) bundle install
    
Install a javascript runtime

    sudo apt-get install nodejs

Start the rails server

    rails server

Contributing
============

(*These instructions may be a little outdated and will be re-visited after the beta run is stable)

We use the standard rails testing frameworks in minitest for unit and rubocop for static analysis, these and a good conversation are the criteria for a commit. In order to check that any changes are good run our custom function validation rake task:

    rake validate

We use magic_encoding to insert the UTF-8 header into the ruby files, so if rubocop returns complaining about a missing utf-8 encoding comment, run:

    magic_encoding
    
<Stafford4President>
