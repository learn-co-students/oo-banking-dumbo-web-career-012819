class Transfer
  attr_accessor :status, :amount
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.receiver.valid? && self.sender.valid?
  end

  def execute_transaction
    if (self.sender.valid? && is_valid?)
      self.sender.balance -= amount
      self.receiver.deposit(amount)
      self.status = "complete"
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  # Checks that amount does not exceed sender's balance
  # and that its pending
  def is_valid?
    future_balance = self.sender.balance - amount
    self.status == "pending" && future_balance > 0
  end

  def reverse_transfer
    if self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.balance -= self.amount
      self.status = "reversed"
    end
  end

end
