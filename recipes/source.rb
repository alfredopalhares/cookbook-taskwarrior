git "#{Chef::Config[:file_cache_path]}/task.git" do
  repository node["taskwarrior"]["source"]["git_repository"]
  reference node["taskwarrior"]["source"]["git_revision"]
  action :sync
end

bash "Install taskwarrior" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/task.git"
  code <<-EOH
  cmake .
  make
  make install
  EOH
end
