require "pry"

class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  @@all = []

  def initialize(sender, receiver, amount)
  	@sender = sender
  	@receiver = receiver
  	@status = "pending"
  	@amount = amount
  end

  def valid?
  	if @sender.valid? == true && @receiver.valid? == true
  		true
  	else
  		false
  	end
  end

  def execute_transaction
  	if @amount > sender.balance
  		@status = "rejected"
  		"Transaction rejected. Please check your account balance."
  	elsif sender.valid? == true && @@all.include?(self) == false
	  	@sender.balance -= @amount
		@receiver.balance += @amount
		@status = "complete"
		@@all << self
	else
		@status = "complete"
	end
  end

  def reverse_transfer
  	if @@all.include?(self)
	  	@sender.balance += @amount
	  	@receiver.balance -= @amount
	  	@status = "reversed"
	end
  end
end
