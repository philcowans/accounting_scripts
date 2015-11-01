#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'current_account_statement'

input = File.read(ARGV[0])
match_list = []
statement = CurrentAccountStatement.new(input, match_list)

statement.categorised_transactions.each do |transaction|
  puts "#{transaction[:date].to_s}, #{transaction[:description]}, #{transaction[:value]}, #{transaction[:categories].inspect}"
end

statement.uncategorised_transactions.each do |transaction|
  puts "#{transaction[:date].to_s}, #{transaction[:description]}, #{transaction[:value]}"
end
