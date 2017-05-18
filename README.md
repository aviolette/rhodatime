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

### Offset times

Local date/times represent time without an offset.  OffsetDateTime represents time with an offset from UTC.  This offset is internally represented as an offset in seconds.


ZoneOffset abstracts a numeric offset from UTC.
````
> ZoneOffset.of_time(-5).to_s     # minus five hours from UTC
"-05:00"

> ZoneOffset.of_time(5, 45).to_s  # plus five hours and 45 minutes from UTC 
"+05:45"

> ZoneOffset.of_time(5, 45).offset_seconds
20700 
````

Create an OffsetDateTime from a LocalDateTime 
 ````
 > dt = LocalDateTime.of(2015, 10, 5, 10, 1, 2, 3)
 
 > dt.to_s
 "2015-10-05T10:01:02.003" 
 
 > dt.apply_offset(ZoneOffset.of_time(-5)).to_s
 "2015-10-05T05:01:02.003-05:00"
 ````

Create an OffsetDateTime at current time with current zone

````
> OffsetDateTime.now.to_s
"2017-05-16T17:07:58.508-05:00" 

> OffsetDateTime.now.offset.to_s
"-05:00"
````

Create an OffsetDateTime from an ISO string
````
> OffsetDateTime.parse("2017-05-16T17:07:58.508-05:00")
#<RhodaTime::OffsetDateTime:0x007fc0fba0bb80 @date=#<RhodaTime::LocalDate:0x007fc0fba11080 @year=2017, @month=5, @day=16>, @time=#<RhodaTime::LocalTime:0x007fc0fba0bd10 @hour=17, @minute=7, @second=58, @millis=508>, @offset=#<RhodaTime::ZoneOffset:0x007fc0fba0bba8 @offset_seconds=-18000>> 
````

### Enumerating over a range

A common issue that comes up with time series data is enumerating over a range of two dates.  This library has that behavior built in:

````
> dt1 = LocalDate.of(2017, 4, 10).at_start_of_day

# build a range from 2017-4-10 until 2017-4-15, then iterate on 12 hour intervals and print the time
> dt1.range_until(dt1.plus_days(5)).on_interval(Duration.of_hours(12)) { | time | puts time }
  2017-04-10T00:00
  2017-04-10T12:00
  2017-04-11T00:00
  2017-04-11T12:00
  2017-04-12T00:00
  2017-04-12T12:00
  2017-04-13T00:00
  2017-04-13T12:00
  2017-04-14T00:00
  2017-04-14T12:00
  2017-04-15T00:00

````

Another variation is to inject an accumulator

````
> dt1 = LocalDate.of(2017, 4, 10).at_start_of_day

# build a range from 2017-4-10 until 2017-4-15, then iterate on 12 hour intervals accumulate time into array
> dt1.range_until(dt1.plus_days(5)).inject_on_interval(Duration.of_hours(12), []) { | acc, time | acc << time.to_s }
   => ["2017-04-10T00:00", "2017-04-10T12:00", "2017-04-11T00:00", "2017-04-11T12:00", "2017-04-12T00:00", "2017-04-12T12:00", "2017-04-13T00:00", "2017-04-13T12:00", "2017-04-14T00:00", "2017-04-14T12:00", "2017-04-15T00:00"] 

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

