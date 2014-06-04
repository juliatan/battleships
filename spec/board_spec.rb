require 'board'

describe Board do

	let(:board) { Board.new(capacity: 10) }
	let(:cell) {Cell.new}

	context 'at initialization' do
		it 'is a hash' do
			expect(board.representation.class).to eq Hash
		end

		it 'has 100 elements' do
			expect(board.representation.count).to eq 100
		end 

		it 'each value is a Cell object' do
			board.representation.values.each do |cell|
				expect(cell.class).to eq Cell
			end
		end

		it 'contains cell objects with empty status' do
			board.representation.values.each do |cell|
				expect(cell.status).to eq :empty
			end
		end

		it 'has a maximum ship capacity' do
			expect(board.capacity).to eq 10
		end
	end

	context 'Board\'s relation-ship' do
		
		it 'can build a ship' do
			ship1 = double :ship1, coordinates: ["A1", "A2", "A3"]

			board.build(ship1)
			["A1", "A2", "A3"].all? do |coord|
				expect(board.representation[coord].status).to eq :ship
			end
		end

		it 'knows that it has a ship' do
			ship = double :ship, coordinates: ['A1', 'A2', 'A3']
			board.build(ship)
			board.representation.values.any? do |cell|
				expect(cell.status).to eq :ship
			end
		end

		it 'can contain ships' do
			expect(board.ship_holder).to eq []
		end

		it 'knows there are two ships on the board' do
			ship1 = double :ship, coordinates: ['A1', 'A2', 'A3']
			ship2 = double :ship, coordinates: ['C1', 'C2']
			board.build(ship1)
			board.build(ship2)
			expect(board.ship_holder).to eq [ship1, ship2]
		end

		it 'knows when a ship is sunk' do
			ship = Ship.new ['A1']
			board.build(ship)
			cell.attempt('A1', board, ship)
			expect(board.sunk_ship_holder).to eq [ship]
		end

		it 'knows it cannot have more than 10 ships' do
			10.times {board.build(Ship.new([]))}
			new_ship = Ship.new []
			expect{board.build(new_ship)}.to raise_error RuntimeError
		end

		it 'knows when all the ships are sunk' do
			ship = Ship.new ["A1"]
			10.times {board.build(ship)}
			10.times {cell.attempt('A1', board, ship)}
			expect(board.sunk_ship_holder.count).to eq board.capacity
		end

	end

	it 'communicates to the game that all the ships are sunk'

	it 'informs the opponent\'s board about each hit(??)'

end