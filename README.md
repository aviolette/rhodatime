# RhodaTime

This is in development

## Overview

Time library for Ruby that mimics the semantics of Java's Joda-Time and Java Time's libraries.  Features:

* Immutable local time / date classes
* Fluent interfaces for adding/subtracting/building those classes
* Advanced time formatting and parsing
* Time zone and offsets as a separate concept
* Classes for representing duration and time periods
* Clock for abstracting system time and time zone

## Usage
### Local Dates, Times, Date-times

Local dates, times, and date-times are representations of times without a time zone.

````
> date = LocalDate.of(2017, 5, 3)
> date.year
2017
> date = date.plus_years(5)
 #<RhodaTime::LocalDate:0x007fa45f248078 @year=2022, @month=5, @day=3>

````

## Development

To test locally:

````
rake test
````
  
To build locally:

````    
gem build rhodatime.gemspec
gem install rhodatime-<currentversion>.gem
````

