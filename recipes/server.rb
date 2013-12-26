include_recipe "git"
include_recipe "build-essential"
include_recipe "cmake"
include_recipe "perl"
include_recipe "python"
include_recipe "apt"

%w{ libgnutls-dev libreadline6 uuid-dev }.each do |pkg|
  package pkg
end

git "#{Chef::Config[:file_cache_path]}/taskd.git" do
  repository node["taskwarrior"]["server"]["git_repository"]
  reference node["taskwarrior"]["server"]["git_revision"]
  action :sync
  notifies :run, "bash[Install taskd]"
end

bash "Install taskd" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}/taskd.git"
  code <<-EOH
  cmake .
  make
  make install
  EOH
  action :nothing
end

user "taskd" do
  home node["taskwarrior"]["server"]["data_dir"]
  system true
end
