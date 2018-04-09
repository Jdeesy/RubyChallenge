# Method parse_csv
# Use the CSV file that was initialized
# for each row inside of it is a new object
# shovel those objects into the all_auctions array

# Method populate_data
# go over each auction
# we then want to populate the display_data hash with information
# 	only include name, city, vehicles_sold,	total_profit (winning_bid - seller_payout),	average_profit (total_profit / vehicles_sold)
# Check if auction name is already included
# 	IF 
# 		name is there, add to the data
# 	Else
# 		populate data
# make sure you exclude nil

# Method print_data
# loop over the display_data hash
# print out needed info

require 'csv'
file = 'challenge-data.csv'

class Auctions
	attr_reader :auctions
	
	def initialize(file_name)
		@file_name = file_name
		@auctions = []
		@display_data = {}
	end

	def parse_csv
		CSV.foreach(@file_name, headers: true) do |row|
			@auctions << row
		end
	end

	def populate_data
		@auctions.each do |auction|
			name = auction['auction name']
			total_profit = (auction["winning bid"].to_i - auction["seller payout"].to_i)

			if @display_data[name]
				@display_data[name][:vehicles_sold] += 1,
				@display_data[name][:total_profit] += total_profit
				@display_data[name][:average_profit] = (@display_data[name][:total_profit] / @display_data[name][:vehicles_sold])
			elsif name
				@display_data[name] = {name: name, city: auction["city"], vehicles_sold: 1, total_profit: total_profit, average_profit: total_profit}
			end
		end
		# p @display_data
	end

	def print_data
		puts "Auction Name || City || Vehicles Sold || Total Profit || Average Profit"
		@display_data.each do |name, data|
			puts "#{name} || #{data[:city]} || #{data[:vehicles_sold]} || #{data[:total_profit]} || #{data[:average_profit]}"
		end
	end

end

test = Auctions.new(file)
test.parse_csv
# p test.auctions
test.populate_data
test.print_data