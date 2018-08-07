#!/usr/bin/ruby
require 'serialport'

arg0 = ARGV[0]
arg1 = ARGV[1]
arg2 = ARGV[2]

def prestart(arg0, arg1)
  @ser = SerialPort.new arg0, arg1.to_i
rescue StandardError
  puts "Not possible to open #{arg0}"
  exit
end

def logfile
  time = Time.now
  t = "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}.log"
  @file = File.open(t, 'a+')
rescue StandardError
  puts 'Not possible to create file'
  exit
end

def log
  puts 'Logging started'
  loop do
    while (buff = @ser.gets.chomp)
      @file.puts buff
      puts buff if ARGV[2] == '-v'
    end
  end
rescue StandardError
  puts 'Timed out'
  exit
end

def check(arg1, arg2)
  if !arg2.nil? && (arg2 != '-v')
    puts 'incorrect flag'
    exit
  elsif !%w[9600 38400 115200 460800].include? arg1
    puts 'incorrect baud rate'
    exit
  end
end

check arg1, arg2
prestart arg0, arg1
logfile
log
