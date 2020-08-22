require 'statement'

require 'CSV'

class CreditCardStatement < Statement
  private

  def parse(input)
    rows = CSV.parse(input)
    header = rows.shift
    rows.each do |row|
      date = Date.parse(row[header.find_index('Date')])
      description = row[header.find_index('Description')].strip
      value = -row[header.find_index('Amount')].to_f
      @transactions << {:date => date, :description => description, :value => value, :account_name => @account_name}
    end
  end
end
