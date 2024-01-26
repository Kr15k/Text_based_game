require 'json'

json_file = File.open 'json_path'

@data_from_file = JSON.load json_file

def initializeGame
  @cur_room = 'underground_room'
  @alive = true
  roomChooser()
  puts "\n\n#{@room_name} \n\n#{@room_description}\n\n"
end

def roomChooser
  @room = @data_from_file[@cur_room]
  @room_name = @room['name'].to_s.split('_').join('').gsub(/(?<=[a-z])(?=[A-Z])/, ' ').upcase
  @room_description = @room['description'].join("\n")
  @room_items = @room['items'].join(" & a ")
end

def playerInput(input)
  if @room['exits'].include?(input)
    @cur_room = @room['exits'][input]
    roomChooser
    puts "\n\n#{@room_name} \n\n#{@room_description}\n\n"
  elsif input.include?("take")
    puts "\nyou take a #{@room_items}\n"
  elsif @room['exits'].none?(input)
    puts "\nU stepped on a mine, and died. wtf"
    @alive = false
  end
end

def game
initializeGame()
  while true
    break unless @alive == true
    roomChooser()
    playerInput(gets.chomp)
  end
end


game()
