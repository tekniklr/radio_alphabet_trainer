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
    if answer.gsub(/\s/, '').downcase == word
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
  time_expended = (Time.now - start_time).to_i
  puts "\nYou answered all letters in #{time_expended} seconds with #{failures} #{failures == 1 ? 'error' : 'errors'}."
end