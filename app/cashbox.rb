module CashBox
  @@deposit = 10
  def self.cashbox
    @@deposit
  end
  def self.deposit(pay)
    @@deposit+=pay
  end
end