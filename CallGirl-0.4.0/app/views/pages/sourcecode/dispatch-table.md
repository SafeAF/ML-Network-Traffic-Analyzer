
```ruby
#!/usr/local/bin/ruby -w
About This Blog (6)
Book Reviews (8)
click to copy
$stack = Array.new Character Encodings def rpn(expression, operations_table) Conferences (4)
Deadly Regular Expressions (4)
type = token =~ /\A\d+\Z/ ? :number : nil Early Steps (4)
operations_table[type || token][token] Higher-Order Ruby (6)
end Key-Value Stores (7)
$stack.pop Language Comparisons (4)
My Heroes (2)
My Projects (5)
require "pp" Non-code (4)
def ast_to_infix(ast) Rails (4)
tokens = expression.split(" ")
tokens.each do |token|
end
if ARGV.size == 2 && ARGV.first == "-i" && ARGV
.last =~ /\A[-+*\/0-9 ]+\Z/
if ast.is_a?(Array)
op, left, right = ast
"(#{ast_to_infix(left)} #{op} #{ast_to_in
fix(right)})"
else
ast.to_s
open in browser PRO version
Are you a developer? Try out the HTML to PDF API
Rubies in the Rough
Ruby Tutorials
Ruby Voodoo
Rusting
(12)
(24)
(4)
(12)
(5)
pdfcrowd.comend
end
ast_table = Hash.new do |table, token|
lambda { |op| s = $stack.pop; $stack << [op
, $stack.pop, s] }
end.merge(:number => lambda { |num| $stack <<
num.to_i })
puts "AST:"
pp(ast = rpn(ARGV.last, ast_table))
puts "Infix:"
Rusting (5)
Screencasts (3)
Terminal Tricks (4)
The Gateway (4)
The Ruby VM Interview (6)
The Standard Library (5)
Throwing Darts (1)
Tools of the Trade (2)
pp ast_to_infix(ast)
elsif ARGV.size == 1 && ARGV.first =~ /\A[-+*\/
0-9 ]+\Z/
calculation_table = Hash.new do |table, token
|
raise "Unknown token:
#{token}."
end.merge(
:number => lambda { |num| $stack << num.t
ActiveRecord
Alternative Implementations
APIs
o_i },
"+"
=> lambda { $stack << $stack.pop
+ $stack.pop },
"-"
=> lambda { s = $stack.pop; $stac
k << $stack.pop - s },
"*"
=> lambda { $stack << $stack.pop
* $stack.pop },
"/"
open in browser PRO version
Tags
=> lambda { d = $stack.pop; $stac
Are you a developer? Try out the HTML to PDF API
AWS
Blogging
Bugs
Code Reading Community
Concurrency Configuration
Curses
Dart
Data Objects
Databases
Date/Time
pdfcrowd.comk << $stack.pop / d }
Documentation
)
puts rpn(ARGV.first, calculation_table)
Editors
DSLs
Erlang
Error Handling
else
puts "Usage:
#{File.basename($PROGRAM_NAME)}
[-i] RPN_EXPRESSION"
end
Experimentation
Feeds
I originally thought I was being clever using the default
block of a Hash , but the lambda() trick in the AST
translator feels bumpy. I also don't like the global $stack .
And types are under used. Let me try to fix those issues
and convert the API to something a bit more in Ruby's
style:
click to copy
#!/usr/local/bin/ruby -w
@operations_table = Hash.new do |table, tok
en|
if table.include?(:default)
table[:default]
Are you a developer? Try out the HTML to PDF API
Functional Programming
Game Development
Heredocs
Iterators
Git
Hidden Features
Java
Leap Year
Metaprogramming
Mix-ins
Object Orientation
Open Source
Patterns
else
end
For Fun
Multilingualization
def initialize
raise "Unknow token:
FasterCSV
Monitoring
class RPN
open in browser PRO version
Date/Time
#{token}."
Performance
Presentations
Redis
Parsing
Process
Refactoring
pdfcrowd.comend Redis
Refactoring
@types = [[:number, /\A\d+\Z/]] Regular Expression
end Scripting
def type(name, pattern) Syntax
@types << [name, pattern]
end
def method_missing(meth, *args, &block)
@operations_table[meth.to_sym] = block
end
Spam
expression.split(" ").each do |token|
case (type = find_type(token))
when :binary_op
Style
System Administration
Teaching
Terminal I/O
Test-Driven Development
Tokyo Cabinet
def parse(expression, stack = Array.new)
Rust
Unix Shells
Web Services
Unicode
Version Control
XMPP
call_binary_op(token, stack, &@operatio
ns_table[:binary_op])
else
@operations_table[type || token][token,
stack]
end
end
stack.pop
end
private
open in browser PRO version
Are you a developer? Try out the HTML to PDF API
pdfcrowd.comdef find_type(token)
(type = @types.find { |t| t.last === token
}) ? type.first : nil
end
def call_binary_op(operator, stack, &operatio
n)
right = stack.pop
operation[operator, stack.pop, right, stack
]
end
end
if ARGV.size == 2 && ARGV.first == "-i" && ARGV
.last =~ /\A[-+*\/0-9 ]+\Z/
require "pp"
def ast_to_infix(ast)
if ast.is_a?(Array)
op, left, right = ast
"(#{ast_to_infix(left)} #{op} #{ast_to_in
fix(right)})"
else
ast.to_s
end
end
open in browser PRO version
Are you a developer? Try out the HTML to PDF API
pdfcrowd.comcalc = RPN.new
calc.type(:binary_op, /\A[-+*\/]\Z/)
calc.number { |num, stack| stack << num.to_i
}
calc.binary_op { |op, left, right, stack| sta
ck << [op, left, right] }
puts "AST:"
pp(ast = calc.parse(ARGV.last))
puts "Infix:"
pp ast_to_infix(ast)
elsif ARGV.size == 1 && ARGV.first =~ /\A[-+*\/
0-9 ]+\Z/
calc = RPN.new
calc.type(:binary_op, /\A[-+*\/]\Z/)
calc.number { |num, stack| stack << num.to_i
}
calc.binary_op { |op, left, right, stack| sta
ck << left.send(op, right) }
puts calc.parse(ARGV.first)
else
puts "Usage:
#{File.basename($PROGRAM_NAME)}
[-i] RPN_EXPRESSION"
end
I'm not sure if I got everything perfect, but hopefully
there's a good Ruby idiom or two hiding in there. It
```