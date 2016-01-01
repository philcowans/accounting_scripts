#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'credit_card_statement'
require 'current_account_statement'

match_list_input = File.read(ARGV[0])
match_list = []
match_list_input.split("\n").each do |line|
  parts = line.split("\t")
  match_list << [Regexp.new(parts[0]), [parts[1], parts[2], parts[3]]]
end

input = File.read(ARGV[1])
statement = CreditCardStatement.new(input, match_list)

statement.categorised_transactions.each do |transaction|
  puts "#{transaction[:date].to_s},,,,#{ARGV[2]},,#{transaction[:description]},,,,,#{transaction[:value]},#{transaction[:categories].join(',')}"
end

statement.uncategorised_transactions.each do |transaction|
  puts "#{transaction[:date].to_s}, #{transaction[:description]}, #{transaction[:value]}"
end
