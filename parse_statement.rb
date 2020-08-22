#!/usr/bin/env ruby

# ./parse_statement.rb ./data/match_list.csv a:current:./data/current_2016_07.csv a:joint:./data/joint_2016_07.csv c:cc:./data/cc_2016_07_a.csv c:cc:./data/cc_2016_07_b.csv 

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'credit_card_statement'
require 'current_account_statement'

match_list_input = File.read(ARGV.shift)
match_list = []
match_list_input.split("\n").each do |line|
  parts = line.split(',')
  match_list << [Regexp.new(parts[0]), [parts[1], parts[2], parts[3]]]
end

uncategorised_transactions = []

ARGV.each do |arg|
  file_specifier = arg.split(':')
  account_name = file_specifier[1]
  input = File.read(file_specifier[2])
  if file_specifier[0] == 'a'
    statement = CurrentAccountStatement.new(input, match_list, account_name)
  else
    statement = CreditCardStatement.new(input, match_list, account_name)
  end

  statement.categorised_transactions.each do |transaction|
    puts "#{transaction[:date].to_s},,,,#{transaction[:account_name]},,#{transaction[:description]},,,,,#{transaction[:value]},#{transaction[:categories].join(',')}"
  end

  uncategorised_transactions += statement.uncategorised_transactions
end

uncategorised_transactions.each do |transaction|
  puts "#{transaction[:date].to_s},#{transaction[:account_name]},#{transaction[:description]},#{transaction[:value]}"
end
