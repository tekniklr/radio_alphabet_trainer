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

start_time = Time.now

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

time_expended = (Time.now - start_time).to_i
puts "\nYou radioed all letters in #{time_expended} seconds with #{failures} errors."