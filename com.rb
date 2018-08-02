#!/usr/bin/ruby
require 'serialport'

arg0 = ARGV[0]
arg1 = ARGV[1]
arg2 = ARGV[2]

def setup(arg, arg2)
  @ser = SerialPort.new arg, arg2.to_i
rescue StandardError
  puts "Not possible to open #{arg}"
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

def check(var, var2)
  if !var.nil? && (var != '-v')
    puts 'incorrect flag'
    exit
  elsif !%w[9600 38400 115200 460800].include? var2
    puts 'incorrect baud rate'
    exit
  end
end

check arg2, arg1
setup arg0, arg1
logfile
log
