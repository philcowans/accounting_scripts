require 'CSV'

class CurrentAccountStatement
  attr_reader :transactions

  def initialize(input)
    @transactions = []
    parse(input)
  end

  private

  def parse(input)
    rows = CSV.parse(input)
    header = rows.shift
    rows.each do |row|
      date = Date.parse(row[header.find_index('Transaction Date')])
      description = row[header.find_index('Transaction Description')].strip
      value = (row[header.find_index('Credit Amount')].nil? ? 0 : row[header.find_index('Credit Amount')].to_f) -
        (row[header.find_index('Debit Amount')].nil? ? 0 : row[header.find_index('Debit Amount')].to_f)
      @transactions << {:date => date, :description => description, :value => value}
    end
  end
end
