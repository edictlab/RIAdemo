# A middleware for rapid development of RIA in Ruby

This is a demo application utilizing our middleware for the development of Rich Internet Applications (RIA) in the Ruby programming language. It is implemented in JRuby and is based on Vaadin, a Java framework for the RIA development. Data access is performed utilizing the DataMapper object-relational mapper that is adapted in order to be used as a Vaadin container for data binding with the Vaadin user interface components.

The application can run on any operating system that supports the Java Virtual Machine.

## Tutorial for running the demo application

First, we need JRuby.
Install JRuby from the [JRuby site](http://jruby.org) by downloading the appropriate `.zip` file and following the [directions from the site](http://jruby.org/#2).

The demo application stores the data into a Sqlite database utilizing the DataMapper object-relational mapper. Hence, we have to install Sqlite adapter and the DataMapper gem.

### Installation of Sqlite 

  For Debian / Ubuntu, run the following command in the command line:

      $ sudo apt-get install libsqlite3-dev

  For RedHat / Fedora, run the following command:

      $ sudo yum install sqlite-devel

For other Linux distributions run the equivalent command that will install required drivers. 

If you want to run the application on the Windows operating system, install the appropriate drivers for accessing a Sqlite database.

### Installation of DataMapper

#### Manual installation

When we have Sqlite drivers installed, we now install DataMapper gem and its dependencies:

      $ jruby -S gem install datamapper --no-ri --no-rdoc

Now install the following two Ruby gems:

      $ jruby -S gem install jdbc-sqlite3 -v "3.7.2.1" --no-ri --no-rdoc

Now install Sqlite adapter Ruby gem:

      $ jruby -S gem install dm-sqlite-adapter --no-ri --no-rdoc

This command will download and install several Ruby gems.

#### Installation using Bundler 

The required gems can be installed using bundler Ruby gem. First, install bundler gem:

      $ jruby -S gem install bundler --no-ri --no-rdoc

Then type the following command:

      $ jruby -S bundle update

All required gems should be installed.

### Clone the Git project

Install `git` if you haven't done it already. Issue the following command for Ubuntu or similar for other operating system:

      $ sudo apt-get install git

In order to download the demo application we need to issue the appropriate `git clone` command.

      $ git clone git://github.com/edictlab/RIAdemo.git

The command will create the `RIAdemo` directory and download an entire source code required for running the demo application.


### Running the application

We start the application by running the `start-app.rb` Ruby script. This script loads all other required files and libraries, and starts the Jetty application server.

      $ jruby start-app.rb

The application's web interface is accessible at the port 8080. If you run the demo application on the local computer, open the address [http://localhost:8080](http://localhost:8080) in a web browser.


### Architecture of the demo application

The source code of the demo is located in the following files:
- `start-app.rb` - loads all required libraries and starts the Web application.
- `demo-app-ui.rb` - application logic and user interface.
- `data-model.rb` - the DataMapper model for accessing the database.
- `data-init.rb` - initial data that is inserted into the database.
- `test.db` - Sqlite database.
- `lib (directory)` - implementation of the middleware.

