
namespace :switchyard do
	desc 'increment switchyard version number tiny component by 1'
	task :tinyupdate
end

namespace :development do
	desc 'development tasks'
	task :rebuild_bundles do
		FileUtils.rm_f("bin/")
	end
end