#!/usr/bin/ruby
require 'serialport'

  time = Time.now
  t = "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}.log"
  f = File.open(t, 'a+')

  i = ARGV[0]
  ser = SerialPort.new i, 460800
  while true
    while (buff = ser.gets.chomp)
      f.puts buff
      puts buff
    end
  end




