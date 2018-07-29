#!/usr/bin/ruby

i = 0

until i > 255
  x = `ping -c 1 10.11.1.#{i}`
  puts x if x =~ /1 received/
  i += 1
end
