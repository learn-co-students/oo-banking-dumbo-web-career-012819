class Transfer
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if sender.balance < amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif @status != "complete"
      sender.balance -= amount
      receiver.deposit(amount)
      @status = "complete"
    end
  end

  def reverse_transfer
    if @status == "complete"
      sender.deposit(amount)
      receiver.balance -= amount
      @status = "reversed"
    end
  end

end
