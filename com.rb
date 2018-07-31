#!/usr/bin/ruby
require 'serialport'

i = ARGV[0]
verbose = ARGV[1]

def setup (arg)
#460800
  begin
    @ser = SerialPort.new arg, 115200
  rescue
    puts "Not possible to open #{i}"
  end
end

def logfile
  begin
    time = Time.now
    t = "#{time.year}_#{time.month}_#{time.day}_#{time.hour}_#{time.min}.log"
    @file = File.open(t, 'a+')
  rescue
    puts "Not possible to create file"
    puts "Please retry to run com.rb"
  end
end

def log
  while true
    while (buff = @ser.gets.chomp)
      @file.puts buff
      if ARGV[1] == '-v'
        puts buff
      end
    end
  end
end

def check (var)
  begin
    if var != nil and var != '-v'
      raise 'Invalid flag'
    end
    if var == nil
      puts "Start logging"
      puts "Add -v flag for output of serial data in terminal"
    end
  rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
  end
end

check verbose
setup i
logfile
log








