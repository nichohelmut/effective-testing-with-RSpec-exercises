class API < Sinatra::Base
	def initialize(ledger:)
		@ledger = ledger
		super()
	end
end

app = API.new(ledger: Ledger.new)

result = @ledger.record({ 'some' => 'data' })
result.success?
result.expense_id
result.error_message
