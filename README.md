#markdown_to_sql

##Description
Takes data from a markdown-formatted data dictionary convert it to a SQL file, ready for Postgres.

##Usage
: ./markdown_to_sql.rb input_file output_file

##Sample Data Dictionary Example

-

##artists
Name                    | Type                                                | Example
----                    | ----                                                | -------
id                      | SERIAL PRIMARY KEY                                  | 1
name                    | TEXT NOT NULL DEFAULT "unknown"                     | Blue Rodeo
official_site           | TEXT                                                | bluerodeo.com
twitter                 | TEXT                                                | bluerodeo
