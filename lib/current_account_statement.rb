require 'CSV'

class CurrentAccountStatement
  attr_reader :transactions

  def initialize(input, match_list)
    @transactions = []
    parse(input)
    categorise(match_list)
  end

  def categorised_transactions
    @transactions.reject{|transaction| transaction[:categories].nil?}
  end

  def uncategorised_transactions
    @transactions.select{|transaction| transaction[:categories].nil?}
  end

  private

  def categorise(match_list)
    @transactions.each do |transaction|
      match_list.each do |match|
        if transaction[:description] =~ match.first
          transaction[:categories] = match.last
          break
        end
      end
    end
  end

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
