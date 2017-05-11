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

All classes in RhodaTime are in the RhodaTime namespace.  If you are heavily using these classes, you
can dereference the namespace by using include

````
include RhodaTime
````

### Local Dates, Times, Date-times

Local dates, times, and date-times are representations of times without a time zone.

````
> date = LocalDate.of(2017, 5, 3)
> date.year
2017
> date = date.plus_years(5)
 #<RhodaTime::LocalDate:0x007fa45f248078 @year=2022, @month=5, @day=3>
> date = date.minus_months(22).minus_days(5)
 #<RhodaTime::LocalDate:0x007f892e1c9760 @year=2020, @month=6, @day=28> 
> date.to_s
 "2020-06-28"
> date.at_start_of_day
 #<RhodaTime::LocalDateTime:0x007f892e1c0098 @date=#<RhodaTime::LocalDate:0x007f892e1c00e8 @year=2020, @month=6, @day=28>, @time=#<RhodaTime::LocalTime:0x007f892e1c00c0 @hour=0, @minute=0, @second=0, @millis=0>>
> date.at_start_of_day.to_s
 "2020-06-28T00:00"  
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

