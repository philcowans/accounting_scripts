#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'current_account_statement'

input = File.read(ARGV[0])
statement = CurrentAccountStatement.new(input)

puts statement.transactions.inspect
