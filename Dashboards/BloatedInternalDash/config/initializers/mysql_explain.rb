# unless RAILS_ENV == 'production'
#   module ActiveRecord
#     module ConnectionAdapters
#       class MysqlAdapter < AbstractAdapter             def select_with_explain(sql, name = nil)               explanation = execute_with_disable_logging('EXPLAIN ' + sql)               e = explanation.all_hashes.first               exp = e.collect{|k,v| " | #{k}: #{v} "}.join               log(exp, 'Explain')               select_without_explain(sql, name)             end             def execute_with_disable_logging(sql, name = nil) #:nodoc:               #Run a query without logging               @connection.query(sql)             rescue ActiveRecord::StatementInvalid => exception
#         if exception.message.split(":").first =~ /Packets out of order/
#           raise ActiveRecord::StatementInvalid, "'Packets out of order' error was received from the database. Please update your mysql bindings (gem install mysql) and read http://dev.mysql.com/doc/mysql/en/password-hashing.html for more information.  If you're on Windows, use the Instant Rails installer to get the updated mysql bindings."
#         else
#           raise
#         end
#       end
#       alias_method_chain :select, :explain
#       end
#     end
#   end
# end