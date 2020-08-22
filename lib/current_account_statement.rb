require 'statement'

require 'CSV'

class CurrentAccountStatement < Statement
  private

  def parse(input)
    rows = CSV.parse(input)
    header = rows.shift
    rows.each do |row|
      date = Date.parse(row[header.find_index('Transaction Date')])
      description = row[header.find_index('Transaction Description')].strip
      value = (row[header.find_index('Credit Amount')].nil? ? 0 : row[header.find_index('Credit Amount')].to_f) -
        (row[header.find_index('Debit Amount')].nil? ? 0 : row[header.find_index('Debit Amount')].to_f)
      @transactions << {:date => date, :description => description, :value => value, :account_name => @account_name}
    end
  end
end
