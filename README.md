# RhodaTime

Like Joda-Time but for Ruby.

## Overview

Time library for Ruby that mimics the semantics of Java's Joda-Time and Java Time's libraries.  Features:

* Immutable local time / date classes
* Fluent interfaces for adding/subtracting/building those classes
* Advanced time formatting and parsing
* Time zone and offsets as a separate concept
* Classes for representing duration and time periods
* Clock for abstracting system time and time zone

## Usage

All classes in RhodaTime are in the RhodaTime namespace.  If you are heavily using these classes, you can dereference the namespace by using include

````
include RhodaTime
````

### Clock

A clock is an abstraction of the system clock.  It keeps track of current epoch time and zones.  There is a FakeClock instance in the test directory that can be used for testing.

````
> Clock.instance.now
1494507010522 # epoch time in millis

> Clock.instance.offset
-18000 # offset of current zone in seconds
````

### Local Dates, Times, Date-times

Local dates, times, and date-times are representations of times without a time zone.

Local dates:
````
> date = LocalDate.now             # the current date

> date = LocalDate.of(2017, 5, 3)  # a specific date

> date.year
2017

>  date.with_year(2018).minus_months(22).plus_days(5).to_s
"2016-07-08"

> date.at_start_of_day.to_s
 "2017-05-03T00:00"  
````

Local times:
````
````

Local date-times:
````
> dt = LocalDateTime.now

> dt = LocalDateTime.of(2017, 6, 12, 21, 30, 50, 4)

> dt.to_s
"2017-05-11T16:08:50.004"

> dt.plus_days(32).plus_hours(5).with_minute(30).to_s
"2017-06-12T21:30:50.004" 

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

