require 'json'

json_file = File.open "/home/kk/Programming/Ruby/testing/file.jsonc"

@data_from_file = JSON.load json_file
@cur_room = "underground_room"
@alive = true

def roomChooser
  @room = @data_from_file[@cur_room]
  room_name = @room["name"].to_s.split('_').join('').gsub(/(?<=[a-z])(?=[A-Z])/, ' ').upcase
  room_description = @room["description"]
  room_items = @room["items"]
  puts "\n#{room_name} \n\n#{room_description}"
end

def roomChecker(input)
  if @room["exits"].include?(input)
    @cur_room = @room["exits"][input]
  else
    puts "\nU died man, wtf"
    @alive = false
  end
end

while true
  if @alive == true
    roomChooser
    roomChecker(gets.chomp)
  else
    break
  end
end
