## Tech Test
### Description
The test is as follows:

Write a ruby script that:

a. Receives a log as argument (webserver.log is provided)
e.g.: ./parser.rb webserver.log


b. Returns the following:
1. list of webpages with most page views ordered from most pages views to less page views e.g.:
```
/home 90 visits
/index 80 visits
etc...
```
2. list of webpages with most
unique page views also ordered
e.g.:
```
/about/2 8 unique views
/index 5 unique views
etc...
```

### Assumptions
A log file has only ipv4 and we assume that `999.999.999.999` is valid too.

### Installation

Install all dependencies by command:
```
bundle install
```

### Execution

Ruby script should be executive on your machine. There are two options:
1. Change file privileges by `chmod +x app.rb` and run like `./app.rb`
2. Run via interpeter `ruby app.rb`

A user should run the script with a log file:
```
./app.rb webserver.log
```

Script supports another option with `-f` flag:
```
./app.rb -f webserver.log
```
To learn more type with the flag `-h`:
```
./app.rb -h
```

### Tests
Tests are written using RSpec. To run them:
```
rspec
```

### Possible ideas

1. Instead of keeping a hash with arrays we can use OpenStruct.
2. Add tests for different input and output
