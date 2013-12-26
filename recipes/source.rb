git "#{Chef::Config[:file_cache_path]}/task.git" do
  repository "git://tasktools.org/task.git"
  reference "HEAD"
  action :sync
end
