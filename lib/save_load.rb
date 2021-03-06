# frozen_string_literal: true

require 'yaml'

module GameMemory
  def save_game(instance)
    puts 'Enter file name'
    file = gets.chomp.to_s
    dump = YAML.dump(instance)
    Dir.mkdir 'save' unless Dir.exist? 'save'
    if File.exist?("save/#{file}")
      puts 'Saving failed. Filename exists.'
    else
      File.write(File.open("save/#{file}.yaml", 'w+'), dump)
      puts 'saved!'
    end
  end

  def load_game
    puts ''
    files = Dir.glob('save/*')
    length = files.length

    length.times do |i|
      files[i] = files[i].slice(5, files[i].length)
        puts files[i]
    end
    puts "\nAll the saving is here.\n" + "Please input file's name."
    input = gets.chomp.to_s
    until files.include?("#{input}.yaml")
      puts "\nPlease input again!"
      input = gets.chomp.to_s
    end
    filename = "save/#{input}.yaml"
    old_game = YAML.load(File.read(filename))
    old_game.game_loop
  end
end
