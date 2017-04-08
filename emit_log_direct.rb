#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new(:automatically_recover => false)
conn.start

ch       = conn.create_channel
x        = ch.direct("direct_logs") #exchange type = direct
	#a message goes to the queues whose binding key exactly matches the routing key of the message.
severity = ARGV.shift || "info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg, :routing_key => severity)
puts " [x] Sent '#{msg}'"

conn.close
