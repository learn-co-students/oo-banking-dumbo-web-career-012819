require 'pry'
class Transfer
    attr_accessor :status
    attr_reader :sender, :receiver, :amount

  def initialize(sender,receiver,amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
     #binding.pry
  end

  def valid?
      sender.valid? && receiver.valid?
          #binding.pry
  end

  def execute_transaction
      if valid? && @status =="pending"
         receiver.balance+=@amount
         sender.balance-=@amount
         @status = "complete"
     end

      if sender.valid? == false
            @status = "rejected"
            return "Transaction rejected. Please check your account balance."
      end
  end

   def reverse_transfer
       if @status=="complete"
       receiver.balance-=@amount
       sender.balance+=@amount
       @status = "reversed"

       end
   end
end
