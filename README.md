# RIA development in Ruby - Prototype

This is a demo application for the development of Rich Internet Applications (RIA) inthe Ruby programming language. It is implemented in JRuby utilizing Vaadin, a Java framework for the RIA development.

## Tutorial for running the demo application

First, we need JRuby.
Install JRuby from the [JRuby site](http://jruby.org) following the [directions from the site](http://jruby.org/#2).

The demo application stores the data into a Sqlite database utilizing the DataMapper object-relational mapper. Hence, we have to install Sqlite adapter and the DataMapper gem.

### Installation of Sqlite adapter
  For Debian / Ubuntu
  `sudo apt-get install libsqlite3-dev`

  For RedHat / Fedora
  `sudo yum install sqlite-devel`

Now install the Sqlite3 adapter Ruby gem:
`jruby -S gem install dm-sqlite-adapter`

This command will download and install several Ruby gems.

### Installation of DataMapper
When we have Sqlite3 adapter installed we now install the DataMapper gem and its dependancies:
      `$ jruby -S gem install datamapper



## Clone the Git project
In order to download the demo application we need to issue the `git clone` command.

  `$ git clone git://github.com/ectlab/RIAdemo.git`

The command will create  `RIAdemo` directory and download an entire source code required for running the demo application.

# Run the application

We start the application by running the `start-app.rb` Ruby script. This script loads all other required files and libraries, and starts the Jetty application server.

  `$ jruby start-app.rb`


