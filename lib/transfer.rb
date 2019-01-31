require 'pry'

class Transfer
  # your code here
  attr_accessor :status, :amount
  attr_reader :sender, :receiver
  
  def initialize(sender, receiver, amount) 
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end
  
  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end
  
  def execute_transaction 
    if @sender.balance > @amount && @status == "pending"
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else
      # sender.self.status = "rejected"
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end
  
  def reverse_transfer 
    if @status == "complete"
      @status = "reversed"
      @sender.balance += @amount
      @receiver.balance -= @amount
    end
  end
  
end
