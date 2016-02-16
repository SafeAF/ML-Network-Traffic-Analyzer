json.array!(@infrastructures) do |infrastructure|
  json.extract! infrastructure, :id, :name, :purpose, :description, :type, :effectiveness, :utilization, :return_on_assets, :manhours_per_unit_production, :revenue_per_employee, :organizational_unit, :total_klocs, :klocs_ytd, :total_manhours, :manhours_this_month, :manhours_last_month, :average_manhours, :bugs_this_month, :bugs_last_month, :average_bugs_month, :klocs_this_month, :klocs_last_month, :average_klocs_month, :klocs_per_manhour, :bugs_per_kloc, :defect_removal_rate, :service, :application, :cluster_id, :user_id, :criticality, :network, :admin_id, :operations_id
  json.url infrastructure_url(infrastructure, format: :json)
end
