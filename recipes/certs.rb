package "gnutls-bin"

if not node["taskwarrior"]["server"].attribute?("organization")
  log "The organization attribute is not set, certificates can't be set." do
    level :fatal
  end
end

directory node["taskwarrior"]["server"]["keys_dir"] do
  owner "taskd"
  group "taskd"
  mode 0600
end

bash "Generating CA key" do
  user "root"
  cwd node["taskwarrior"]["server"]["keys_dir"]
  code <<-EOH
    certtool --generate-privkey --outfile ca.key.pem
  EOH
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["keys_dir"]}/ca.key.pem")}
end

template "#{node["taskwarrior"]["server"]["keys_dir"]}/ca.info" do
  source "ca.info.erb"
  owner "root"
  group "root"
  mode 00600
  variables({
    :organization => node["taskwarrior"]["server"]["organization"]
  })
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["keys_dir"]}/ca.cert.pem")}
  notifies :run, "bash[Generating CA Cert]", :immediately
end

bash "Generating CA Cert" do
  user "root"
  cwd node["taskwarrior"]["server"]["keys_dir"]
  code <<-EOH
    certtool --generate-self-signed \
    --load-privkey ca.key.pem \
    --template ca.info \
    --outfile ca.cert.pem
    rm ca.info
    [ -s ca.cert.pem ]
  EOH
  action :nothing
end

bash "Generating Server key" do
  user "root"
  cwd node["taskwarrior"]["server"]["keys_dir"]
  code <<-EOH
    certtool --generate-privkey --outfile server.key.pem
  EOH
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["keys_dir"]}/server.key.pem")}
end

template "#{node["taskwarrior"]["server"]["keys_dir"]}/server.info" do
  source "server.info.erb"
  owner "root"
  group "root"
  mode 00600
  variables({
    :organization => node["taskwarrior"]["server"]["organization"],
    :cn => node["ipaddress"]
  })
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["keys_dir"]}/server.cert.pem")}
  notifies :run, "bash[Generating Server Cert]", :immediately
end

bash "Generating Server Cert" do
  user "root"
  cwd node["taskwarrior"]["server"]["keys_dir"]
  code <<-EOH
    certtool --generate-certificate \
    --load-privkey server.key.pem \
    --load-ca-certificate ca.cert.pem \
    --load-ca-privkey ca.key.pem \
    --template server.info \
    --outfile server.cert.pem
    rm server.info
    [ -s server.cert.pem ]
  EOH
  action :nothing
end

users = data_bag("users")

users.each() do |s|
  u = data_bag_item("users", s)

  bash "Create Organization for the user" do
    user "root"
    cwd node["taskwarrior"]["server"]["home"]
    code <<-EOH
      taskd add org #{u["taskwarrior"]["organization"]} --data #{node["taskwarrior"]["server"]["data_dir"]}
    EOH
    not_if do ::File.directory?("#{node["taskwarrior"]["server"]["data_dir"]}/orgs/#{u["taskwarrior"]["organization"]}") end
  end
end


