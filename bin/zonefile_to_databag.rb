#!/usr/bin/env ruby
require 'zonefile'
require 'optparse'

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: zonefile_to_databag.rb [options]"

  opts.on("-z", "--zonefile FILE", "Parse Zone File") do |v|
    options[:zonefile] = v
  end
end

begin
  optparse.parse!
  if options[:zonefile].nil?
    puts optparse  
    raise OptionParser::MissingArgument
  end 
end


zf = Zonefile.from_file(options[:zonefile])
puts '; MX-Records'
zf.mx.each do |mx_record|
   puts "Mail Exchagne with priority: #{mx_record[:pri]} --> #{mx_record[:host]}"
end

# Show SOA TTL
puts "; Record Time To Live: #{zf.soa[:ttl]}"

# Show A-Records
puts "; A Records:"
zf.a.each do |a_record|
   ttl_text = ''
   if !a_record[:ttl].nil? and a_record[:ttl] != '' and a_record[:ttl] != zf.ttl
     ttl_text = "\"ttl\": \"#{a_record[:ttl]}\", "
   end
   puts  "{ \"type\": \"A\", #{ttl_text}\"name\": \"#{a_record[:name]}\", \"ip\": \"#{a_record[:host]}\"},"
end

puts "; CNAME Records:"
zf.cname.each do |cname_record|
   puts "{ \"type\": \"CNAME\" , \"name\": \"#{cname_record[:name]}\", \"ip\": \"#{cname_record[:host]}\"},"
end
