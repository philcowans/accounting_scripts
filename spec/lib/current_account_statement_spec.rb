require 'current_account_statement'

RSpec.describe CurrentAccountStatement do
  before(:all) do
    input = <<-EOF
Transaction Date,Transaction Type,Sort Code,Account Number,Transaction Description,Debit Amount,Credit Amount,Balance,
30/10/2015,BGC,'01-02-03,12345678,TEST INCOME ,,5259.31,14298.40
29/10/2015,DEB,'01-02-03,12345678,TEST EXPENSE ,4.60,,9039.09
EOF
    @statement = CurrentAccountStatement.new(input)
  end

  it 'should find all the transactions' do
    @statement.transactions.size.should == 2
  end

  it 'should extract the appropriate information' do
    @statement.transactions[0][:date].should == Date.parse('2015-10-30')
    @statement.transactions[0][:description].should == 'TEST INCOME'
    @statement.transactions[1][:date].should == Date.parse('2015-10-29')
    @statement.transactions[1][:description].should == 'TEST EXPENSE'
  end

  it 'should correctly calculate the transaction value' do
    @statement.transactions[0][:value].should == 5259.31
    @statement.transactions[1][:value].should == -4.60
  end
end
