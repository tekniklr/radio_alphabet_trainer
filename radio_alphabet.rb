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
aborted = false
start_time = Time.now

begin
  while letters.count > 0 do
    letter = letters.first
    word = alphabet[letter]
    print "\n#{letter} => "
    answer = gets.strip
    if answer.downcase == word
      completed += 1
      puts "Answered #{completed}/26!"
      letters.shift
    else
      failures += 1
      puts "BRRRAAAAAP"
    end
    letters and letters.shuffle!
  end
rescue Interrupt
  aborted = true
  time_expended = (Time.now - start_time).to_i
  puts "\n\nYou only answered #{completed} #{completed == 1 ? 'letter' : 'letters'}. It took you #{time_expended} seconds. You failed #{failures} #{failures == 1 ? 'time' : 'times'}."
  puts "You run THAT fast?"
end

unless aborted
  # only save a score if they didn't quit
  
  time_expended = (Time.now - start_time).to_i
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