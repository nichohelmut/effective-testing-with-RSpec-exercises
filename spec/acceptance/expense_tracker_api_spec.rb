require 'rack/test'
require'json'
require_relative '../../app/api'

module ExpenseTracker
	RSpec.describe 'Expense Tracker API' do
		include Rack::Test::Methods

		let(:parsed) { JSON.parse(last_response.body) }
		
		def app
			ExpenseTracker::API.new
		end

		def post_expense(expense)
			post '/expenses', JSON.generate(expense)
			expect(last_response.status).to eq(200)

			expect(parsed).to include('expense_id' => a_kind_of(Integer))
			expense.merge('id' => parsed['expense_id'])
		end

		it 'records submitted expenses' do
			pending 'Need to persist expenses'
			coffee = post_expense(
				'payee' => 'Starbucks',
				'amount' => 5.75,
				'date' => '2017-06-10'
			)

			zoo = post_expense(
				'payee' => 'Zoo',
				'amount' => 15.35,
				'date' => '2017-06-10'
			)

			groceries = post_expense(
				'payee' => 'Whole Foods',
				'amount' => 95.75,
				'date' => '2017-06-11'
			)

			get '/expenses/2017-06-10'
			expect(last_response.status).to eq(200)

			expect(parsed).to contain_exactly(coffee, zoo)
		end
	end
end