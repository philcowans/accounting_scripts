class Statement
  attr_reader :transactions

  def initialize(input, match_list, account_name)
    @account_name = account_name
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
end
