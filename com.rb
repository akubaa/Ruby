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

def timestamp
  Time.now.strftime '%Y-%m-%d %H_%M_%S'
end

def logfile
  @file = File.open("#{timestamp}.log", 'a+')
rescue StandardError
  puts 'Not possible to create file'
  exit
end

def log
  puts 'Logging started'
  loop do
    while (buff = @ser.gets.chomp)
      @file.puts "#{timestamp} #{buff}"
      puts "#{timestamp} #{buff}" if ARGV[2] == '-v'
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
