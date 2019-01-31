class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"

  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.status == "pending"
      receiver.deposit(self.amount)
      sender.take_out(self.amount)
      if not valid?
        self.status = "rejected"
        reverse_transfer
        "Transaction rejected. Please check your account balance."
      else
        self.status = "complete"
      end
    end

  end

  def reverse_transfer
    if self.status == "complete"
      sender.deposit(self.amount)
      receiver.take_out(self.amount)
      self.status = "reversed"
    end
  end

end
