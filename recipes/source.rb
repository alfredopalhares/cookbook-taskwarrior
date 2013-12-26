git "#{Chef::Config[:file_cache_path]}/task.git" do
  repository node["taskwarrior"]["source"]["git_repository"]
  reference node["taskwarrior"]["source"]["git_revision"]
  action :sync
end
