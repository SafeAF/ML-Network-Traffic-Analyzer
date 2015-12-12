require "benchmark"
include Benchmark

test = "Foo Bar Baz"
m = test.method(:length)

n = 100000

bm(12) {|x|
x.report("call") { n.times {m.call} }

x.report("send") { n.times {m.send(:length)} }
x.report("eval") { n.times {eval "test.legnth"} }

}