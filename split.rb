#!/usr/bin/ruby

filename = ARGV[0]
surfix = ARGV[1]

def chunker(f_in, out_pref, chunksize = 1_073_741_824)
  File.open(f_in, 'r') do |fh_in|
    until fh_in.eof?
      File.open("#{out_pref}_#{format('%05d', (fh_in.pos / chunksize))}.vcf", 'w') do |fh_out|
        fh_out << fh_in.read(chunksize)
      end
    end
  end
end

chunker filename, surfix, 10_000
