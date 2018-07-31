#!/usr/bin/ruby
require 'serialport'

time = Time.now
t = "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}.log"
f = File.open(t, 'a+')
verbose = ARGV[1]
if verbose == nil
  puts "Start logging to #{t}"
  puts "Add -v flag for output of serial data in terminal"
end
i = ARGV[0]
ser = SerialPort.new i, 460800
while true
  while (buff = ser.gets.chomp)
    f.puts buff
    if ARGV[1] == '-v'
      puts buff
    end
  end
end




