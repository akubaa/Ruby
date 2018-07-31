#!/usr/bin/ruby
require 'serialport'

i = ARGV[0]
verbose = ARGV[1]

def setup(arg)
  # 460800

  @ser = SerialPort.new arg, 115_200
rescue StandardError
  puts "Not possible to open #{i}"
end

def logfile
  time = Time.now
  t = "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}.log"
  @file = File.open(t, 'a+')
rescue StandardError
  puts 'Not possible to create file'
  puts 'Please retry to run com.rb'
end

def log
  loop do
    while (buff = @ser.gets.chomp)
      @file.puts buff
      puts buff if ARGV[1] == '-v'
    end
  end
end

def check(var)
  raise 'Invalid flag' if !var.nil? && (var != '-v')
  if var.nil?
    puts 'Start logging'
    puts 'Add -v flag for output of serial data in terminal'
  end
rescue StandardError => e
  puts e.message
  puts e.backtrace.inspect
end

check verbose
setup i
logfile
log
