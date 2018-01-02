def chunker f_in, out_pref, chunksize = 1_073_741_824
  File.open(f_in,"r") do |fh_in|
    until fh_in.eof?
      File.open("#{out_pref}_#{"%05d"%(fh_in.pos/chunksize)}.txt","w") do |fh_out|
        fh_out << fh_in.read(chunksize)
      end
    end
  end
end
filename = ARGV[0]
surfix = ARGV[1]
chunker filename, surfix, 10000000