require 'sinatra/base'
require'json'
require_relative 'ledger'

module ExpenseTracker
	class API < Sinatra::Base

		post "/expenses" do
			expense = JSON.parse(request.body.read)
			result = @ledger.record(expense)
			JSON.generate('expense_id' => result.expense_id)

			if result.success?
				JSON.generate('expense_id' => result.expense_id)
			else
				status 422
				JSON.generate('error' => result.error_message)
			end
		end

		get "/expenses/:date" do
			JSON.generate([])
		end

		def initialize(ledger: Ledger.new)
			@ledger	= ledger
			super()
		end
	end
end
