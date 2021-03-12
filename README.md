# Rails Active Record Query Syntax

## Overview
- Active Record is a crown jewel of the Rails framework.
- Rails and Active Record have an incredibly rich query syntax to help your code that looks up information in the database readable and maintainable.

## Learning Objectives
- Interacting with Active Record query syntax
- Exploring the differences and similarities between SQL queries and Active Record

### Setup:
- git clone
- cd into folder
- $ bundle
- $ yarn
- $ rails db:create
- $ psql country < ~/Desktop/countries.sql
- $ rspec spec/models/country_query_specs.rb

## Process
- This application has a spec file of failing tests in *spec/models/country_queries_spec.rb*
- Add logic to each spec to get the tests passing

## In Terminal
- $ rspec spec/models/country_query_specs.rb


## Active Record Query Syntax
Active Record query syntax is a mesh between Ruby code and SQL clauses. It provides the developer a lot of power to make very specific database queries.

### WHERE and FIRST
Find the first country in the database with a code of 'RUS':
```ruby
russia = Country.where(code: 'RUS').first
# Generates the following SQL:
# "SELECT "country".* FROM "country" WHERE "country"."code" = 'RUS'"
```
Notice the `.first` at the end of that query. The code `Country.where(code: 'RUS')` returns an Active Record Relation, which is a lot like an array. We only are interested in the first result, so we call `.first` and get back the first instance in that array-ish thing.

### Multiple WHERE Clauses
We can chain together multiple clauses in our search:
```ruby
countries = Country.where(continent: "Asia").where("surfacearea > 100000")
# Generates SQL:
# "SELECT "country".* FROM "country" WHERE "country"."continent" = 'Asia' AND (surfacearea > 100000)"
```

This time we get a set of countries back of course, because there is more than one. Cool!

### Custom Selects
We can use custom selects too, if we need to do something unique. Checkout this query:
```ruby
countries = Country.where("governmentform LIKE '%Monarchy%'")

# Generates SQL:
# "SELECT "country".* FROM "country" WHERE (governmentform LIKE '%Monarchy%')"
```

That opens up a whole new realm of possibilities, doesn't it? If you can dream up a query you want to run, you can probably do it with Active Record's flexible `.where` method.

### ORDER and LIMIT

Want to get the first record based on one column in the database?  We can do that with Active Record like this:

```ruby
country = Country
  .order("surfacearea ASC")
  .limit(1)
  .first

# generates the SQL:
# "SELECT "country".* FROM "country" ORDER BY surfacearea ASC LIMIT 1"

# note: "surfacearea DESC" would reverse that sort order
```

### PLUCK
Pluck is a cool tool to get just one attribute of a record returned to you in an array.  We use it like this:

```ruby
countries = Country
  .order(:surfacearea)
  .limit(10)
  .pluck(:name)

# Generates the SQL:
# SELECT "country"."name" FROM "country" ORDER BY "country"."surfacearea" ASC LIMIT 10

# and returns
# ["Holy See (Vatican City State)", "Monaco", "Gibraltar", "Tokelau", "Cocos (Keeling) Islands", "United States Minor Outlying Islands", "Macao", "Nauru", "Tuvalu", "Norfolk Island"]
```

### Aggregates Like SUM
If you need to sum up a column in your query, you can do that as well.  What if we wanted to sum up all the land mass of Europe?  

```ruby
countries = Country
  .where(continent: 'Europe')
  .pluck(:surfacearea)
  .sum
```
