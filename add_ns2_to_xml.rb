#!/usr/bin/ruby

ARGV << '--help' if ARGV.empty?

if ARGV[0] == '--help'
  puts 'Please, insert filename'
  puts 'exempel:'
  puts 'ruby hex_to_ascii.rb filename.txt'
  exit
end

choice = ARGV[0]
unless File.file?(choice)
  puts "Didn't find your file"
  puts 'Please, try again with correct filename'
  exit
end

file = File.open(choice, 'r+')
file2 = File.open('result.xml', 'w+')
file.each_line do |line|
  if line =~ /(<)[^?]/
    find = line
    check1 = find.gsub(/(<)/, '<ns2:')
    check2 = check1.gsub(%r{(<ns2:\/)}, '</ns2:')
    file2.puts check2
  else
    file2.puts line
  end
end
