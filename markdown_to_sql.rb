#!/usr/bin/env ruby

if ARGV.length < 2
  puts "\n\nUsage: ./markdown_to_sql.rb <input_file> <output_file>\n\n"

  puts "Description: This script will take a data dictionary markdown file and "\
       "convert it to a SQL file.\n\n"

  puts "The data dictionary must be in the following format:\n\n"

  puts "# Database Definition\n"\
       "##artists\n"\
       "Name\t\t| Type\t\t| Example\n"\
       "----\t\t| ----\t\t| -------\n"\
       "id\t\t| SERIAL PRIMARY KEY\t\t| 1"\
       "name\t\t| TEXT NOT NULL DEFAULT \"unknown\" "\
       "...\n\n"
  puts "Your data dictionary markdown table could include examples and "\
       "other columnar data, and this script will happily ignore it.\n\n"

else
  md_file = File.new(ARGV[0], "r").readlines << "\n"

  columns = []
  output = ""
  prim = ""

  md_file.each do |line|
  tbl_name = line.match(/##([a-z_]+)$/)
  col_name = line.match(/^([a-z_]+)\s+\|\s([a-zA-Z0-9 "'.\(\)]+)/)
  end_table = line.match(/^\n$/)
  p_key = line.match(/^(PRIMARY KEY \([a-z_, ]+\))$/)

  if tbl_name
    tbl = "CREATE TABLE #{tbl_name[1]} (\n"
    output << tbl
  end

  if col_name
    col = "#{col_name[1]} #{col_name[2]}"
    columns << "\t#{col.rstrip}"
  end

  if p_key
    prim = ",\n\t#{p_key}"
  end

  if end_table
    if !columns.empty?
      cols = columns.join(",\n")
      end_line = "\n);\n\n"
      output << cols << prim << end_line
      columns.clear
    end
  end

  end

  sql_file = File.new(ARGV[1], "w+")
  sql_file.puts output
  sql_file.close
end
