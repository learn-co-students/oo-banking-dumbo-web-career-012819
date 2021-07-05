class Transfer
  # your code here
  attr_reader :sender, :receiver
  attr_accessor :status, :amount
  def initialize(sender,receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid? && @sender.balance > self.amount ? true: false
  end

  def execute_transaction

    if self.valid?
      self.receiver.balance+=self.amount
      self.sender.balance-=self.amount
      self.status="complete"
      self.sender.status="closed"
    else 
      self.status="rejected"
      "Transaction rejected. Please check your account balance."
    end

  end

  def reverse_transfer
    execute_transaction
    self.receiver.balance-=self.amount  
    self.sender.balance+=self.amount
    self.status="reversed"
  end
end
