require 'ffi/pcap'

pcap = FFI::PCap::Live.new(dev: '\Device\NPF_{76B63309-0E94-4BBB-9856-9B8C072A321E}') # for this time, listening is active, as show with stats

pcap.stats
pcap.stats.ps_recv

pcap.datalink.describe

pakt = []

pcap.loop(count: -1) do |_this, pkt| # :count => -1 for infinite loop, break with .breakloop method
  pakt << pkt
  puts "#{pkt.time} :: #{pkt.len}"
  pkt.body.each_byte { |x| print format('%0.2x ', x) }
  pcap.loop(count: 2) { |_t, p| Hexdump.dump(p.body); puts "\n"; }
  putc "\n"
end
