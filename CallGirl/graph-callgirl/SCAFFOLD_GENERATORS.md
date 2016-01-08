
rails generate scaffold Ip address:string hostname:integer dns:string isp:string netblock:string subnet:string network:references reputation:integer dns:references organization:references --no-migration

rails generate scaffold Project name:string description:string details:text infrastructure:references research:references developer:references application:references projected_completion:datetime username:references user:references member:references manhours:integer eta:integer completion_percentage:float --no-migration

rails generate scaffold Issuelist name:string description:string project:references --no-migration

rails generate scaffold Issue name:string author:string assignee:string user:references labels:string label:references --no-migration

rails generate scaffold Tasklist name:string desc:string total_tasks:integer project:references --no-migration

rails generate scaffold Task name:string description:string body:text content:text header:string heading_one:string heading_two:string project:references --no-migration

rails generate scaffold Todo name:string desc:string eta:datetime estimated_manhours:integer total_manhours:integer ratio_actual_manhours:float details:text tasklist:references user:references priority:integer --no-migration

rails generate scaffold Milestone name:string heading:string body:text duedate:datetime complete:float open:integer closed:integer --no-migration

rails generate scaffold Label name:string label:string issue:references milestone:references --no-migration

rails generate scaffold Organization name:string address:string phone:string employees:integer details:text description:string criticality:integer --no-migration

rails generate scaffold Infrastructure name:string purpose:string description:string type:string effectiveness:float utilization:float return_on_assets:float manhours_per_unit_production:float revenue_per_employee:float organizational_unit:string total_klocs:float klocs_ytd:float total_manhours:float manhours_this_month:float manhours_last_month:float average_manhours:float bugs_this_month:float bugs_last_month:float average_bugs_month:float klocs_this_month:float klocs_last_month:float average_klocs_month:float klocs_per_manhour:float bugs_per_kloc:float defect_removal_rate:float service:string application:string cluster:references user:references criticality:integer network:string admin:references operations:references --no-migration

rails generate scaffold Service name:string description:string type:string location:string server:references webserver:references machine:references cluster:references user:references distribution:string cluster:string replication:string authority:string purpose:string watchdog:string pid:integer criticality:integer priority:integer network:references manager:references devops:references configuration:text --no-migration

rails generate scaffold Process name:string pid:integer process:string filehandles:string filehandle:integer path:string proctime:float walltime:float io:float netio:float iowait:float memory:float machine:references server:references node:references network:references manager:references application:references service:references --no-migration

rails generate scaffold Cluster user:references infrastructure:references name:string cluster_type:string members:integer resource_manager:string information:text status:string details:text organization:references --no-migration


rails generate scaffold Network name:string purpose:string type:string speed:integer infrastructure:references ownership:string netadmin:string user:references cluster:references gateway_ip:string ping:float hops:integer latency:float router_ip:string broadcast:string address_space:string dns:string ptr_record:string a_record:string reverse_address:string network_box:integer operations:references wifi_ssid:string wan_ip:string lan_ip:string --no-migration

rails generate scaffold Domainname ip:references cname:string aname:string mx:string mx2:string mx3:string mx4:string hostname:string reverse_lookup:string location:string isp:string organisation:references network:references server:references nameserver1:string nameserver2:string --no-migration

rails generate scaffold Domainnamesystem ip:references cname:string aname:string mx:string mx2:string mx3:string mx4:string hostname:string reverse_lookup:string location:string isp:string --no-migration


rails generate scaffold Group name:string vfilesystem:references user:integer machine:references server:references purpose:string incept_date:datetime access_level:integer --no-migration

rails generate scaffold Gist owner:string user:references member:references name:string total_files:integer description:string total_size:integer github:references git:references project:references content:text --no-migration

rails generate scaffold Github owner:string member:references username:string password:string apikey:string user:references url:string membership:references --no-migration

rails generate scaffold Hardware name:string user:references machine:references inventory:references operations:references type:string purpose:string identifier:string size:string description:string details:text --no-migration

rails generate scaffold Logentry logfile:references name:string message:text facility:string priority:integer logged_at:datetime service:string service:references logentry:references --no-migration

rails generate scaffold Logfile machine:references name:string description:string size:float entries:integer entries_per_sec:float location:string path:string basename:string service:string service:references server:references criticality:integer --no-migration

rails generate scaffold Membership name:string url:string user:references member:references password:string username:string --no-migration

rails generate scaffold NetworkBox name:string hostname:string ip:string type:string manufacturer:string model:string router:string gateway:string network:references infrastructure:references gateway_ip:string os:string operations:references configuration:text --no-migration

rails generate scaffold Network name:string purpose:string type:string speed:integer infrastructure:references ownership:string netadmin:string user:references cluster:references gateway_ip:string ping:float hops:integer latency:float router_ip:string broadcast:string address_space:string dns:string ptr_record:string a_record:string reverse_address:string network_box:integer operations:references wifi_ssid:string wan_ip:string lan_ip:string --no-migration

rails generate scaffold Notification machine:references user:references server:references message:string priority:integer source:string destination:string cluster:references service:references application:references --no-migration












