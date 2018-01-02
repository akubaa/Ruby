#!/usr/bin/env ruby

# TODO: Fix option to search EITHER file or Dir
# TODO Fix veri to be able to use EITHER file or Dir
# TODO Update result.txt template to same as P3 tool

require 'digest'
require 'FileUtils'
require 'optparse'

def checksum(md5)
  Dir["#{md5}/*"].each do |file|
    next if File.directory? file
    puts file
    File.open(file, 'rb') do |io|
      dig = Digest::MD5.new
      buf = ''
      dig.update(buf) while io.read(4096, buf)
      @result.puts "File: \n"
      @result.puts "#{file}\n"
      @result.puts "MD5: #{dig}\n\n"
    end
  end
end

def veri(find)
  c = false
  save = []
  file = File.open('result.txt', 'r+')
  if !find.nil?
    file.each_line do |line|
      if line.include?(find)
        c = true
        next
      end
      save << line if c
      c = false
    end
    if save.all? { |x| x == save[0] }
      puts 'OK'
    else
      save = save.uniq
      puts "\nDiff checksums in file: #{find}"
      save.each do |v|
        puts v.to_s
      end
    end
  else
    puts 'Please insert filename after -v '
  end
end

ARGV << '-h' if ARGV.empty?

options = {}
OptionParser.new do |opts|
  opts.banner = "\nMD5 checksum compare tool.\n"

  opts.on('-f', '--file', 'Add file MD5 checksum to result.txt list') do |f|
    options[:file] = f
  end
  opts.on('-v', '--verify', 'Compare all added MD5 checksum of file from result.txt') do |v|
    options[:verify] = v
  end
  opts.on('-c', '--clear', 'Remove all results from result.txt') do |c|
    options[:clear] = c
  end
  opts.on('-h', '--help', 'Displays help') do
    puts opts
    exit
  end
end.parse!

if options[:file]
  time = Time.new
  file1 = ARGV[0]
  if !file1.nil?
    @result = File.open('result.txt', 'a+')
    @result.puts "#{time.year}-#{time.month}-#{time.day} #{time.hour}:#{time.min} #{file1} result:"
    thr = Thread.new { checksum(file1) }
    thr.join
    puts 'Check result.txt for checksums'
  else
    puts 'Please insert filename after -f '
  end
end

if options[:verify]
  file = ARGV[0]
  veri(file)
end

if options[:clear]
  erase = File.open('result.txt', 'w+')
  erase.truncate(0)
  puts 'Erased all results'
  sleep(2)
  exit
end
