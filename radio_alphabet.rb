#!/usr/bin/env ruby -w

alphabet = {
  'a' => 'alpha',
  'b' => 'bravo',
  'c' => 'charlie',
  'd' => 'delta',
  'e' => 'echo',
  'f' => 'foxtrot',
  'g' => 'golf',
  'h' => 'hotel',
  'i' => 'india',
  'j' => 'juliet',
  'k' => 'kilo',
  'l' => 'lima',
  'm' => 'mike',
  'n' => 'november',
  'o' => 'oscar',
  'p' => 'papa',
  'q' => 'quebec',
  'r' => 'romeo',
  's' => 'sierra',
  't' => 'tango',
  'u' => 'uniform',
  'v' => 'victor',
  'w' => 'whisky',
  'x' => 'x-ray',
  'y' => 'yankee',
  'z' => 'zulu'
}

letters = alphabet.keys.shuffle
completed = 0
failures = 0

puts "Enter the (American) radio alphabet word for the given letter."
puts "To give up on a letter, enter 'FAIL'."
puts "To give up entirely, hit ^C like the quitter you are."

start_time = Time.now

begin
  while letters.count > 0 do
    letter = letters.first
    word = alphabet[letter]
    print "\n#{letter} => "
    answer = gets.strip
    if answer.downcase == word
      completed += 1
      puts "WIN!"
      letters.shift
    elsif answer == 'FAIL'
      puts "'#{word}' is the word you were looking for. Pantywaist."
      letters.shift
    else
      failures += 1
      puts "BRRRAAAAAP"
    end
    if letters.count > 0
      puts "#{alphabet.keys.count - (alphabet.keys.count - letters.count)} letters remain. 'FAIL' cheats, ^C quits."
      letters.shuffle!
    end
  end
rescue Interrupt
  time_expended = (Time.now - start_time).to_i
  puts "\n\nYou only answered #{completed} #{completed == 1 ? 'letter' : 'letters'}. It took you #{time_expended} seconds. You failed #{failures} #{failures == 1 ? 'time' : 'times'}."
  puts "You run THAT fast?"
  exit!
end

time_expended = (Time.now - start_time).to_i  

if completed != alphabet.keys.count
  puts "\n\nYou answered #{completed} #{completed == 1 ? 'letter' : 'letters'} and cheated on #{alphabet.keys.count - completed}."
  puts "It took you #{time_expended} seconds."
  puts "You failed #{failures} #{failures == 1 ? 'time' : 'times'}."
else
  # only save a score if they didn't quit or request any solutions
  
  puts "\nYou answered all letters in #{time_expended} seconds with #{failures} #{failures == 1 ? 'error' : 'errors'}."
  
  # save score and find top score- append line to file of the format 
  # "unixtimestamp solvetime errors"
  now = "#{Time.now.to_i} #{time_expended} #{failures}"
  best = "0 9999 9999" # really, worst
  
  # initialize score file, find the best score in it, add the current 
  # score to it
  filename = '.radio_albhabet'
  if !File.exists?(filename)
    require 'fileutils'
    FileUtils.touch(filename)
  end
  scorefile = File.open(filename, 'r+') do |file|
    file.flock File::LOCK_EX
    lines = file.readlines
    lines.each do |line|
      # compare the current best with this line, if this line is better
      # (less time with less errors) then it becomes the new best
      best_bits = best.split(' ')
      these_bits = line.split(' ')
      if (these_bits[1].to_i < best_bits[1].to_i) || ((these_bits[1].to_i == best_bits[1].to_i) && (these_bits[2].to_i < best_bits[2].to_i))
        # this line is the new best, copy its value
        best = String.new(line)
      end
    end
    # add the current score
    file.print "#{now}\n"
  end
  # is the current score better than any previous score?
  best_bits = best.split(' ')
  if (time_expended.to_i < best_bits[1].to_i) || ((time_expended.to_i == best_bits[1].to_i) && (failures.to_i < best_bits[2].to_i))
    best = String.new(now)
  end
  
  # report high score
  if best == now
    puts "Congratulations, this is your new fastest time."
  else
    best_bits = best.split(' ')
    puts "Your best time is #{best_bits[1]} seconds with #{best_bits[2]} #{best_bits[2] == 1 ? 'error' : 'errors'} on #{Time.at(best_bits[0].to_i).strftime('%B %e, %Y @ %H:%M')}"
  end
  
end