package "gnutls-bin"

if not node["taskwarrior"]["server"].attribute?("organization")
  log "The organization attribute is not set, certificates can't be set." do
    level :fatal
  end
end

bash "Generating CA key" do
  user "root"
  cwd node["taskwarrior"]["server"]["home"]
  code <<-EOH
    certtool --generate-privkey --outfile ca.key.pem
  EOH
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["home"]}/ca.key.pem")}
end

template "#{node["taskwarrior"]["server"]["home"]}/ca.info" do
  source "ca.info.erb"
  owner "root"
  group "root"
  mode 00600
  variables({
    :organization => node["taskwarrior"]["server"]["organization"]
  })
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["home"]}/ca.cert.pem")}
  notifies :run, "bash[Generating CA Cert]", :immediately
end

bash "Generating CA Cert" do
  user "root"
  cwd node["taskwarrior"]["server"]["home"]
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
  cwd node["taskwarrior"]["server"]["home"]
  code <<-EOH
    certtool --generate-privkey --outfile server.key.pem
  EOH
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["home"]}/server.key.pem")}
end

template "#{node["taskwarrior"]["server"]["home"]}/server.info" do
  source "server.info.erb"
  owner "root"
  group "root"
  mode 00600
  variables({
    :organization => node["taskwarrior"]["server"]["organization"],
    :cn => node["ipaddress"]
  })
  not_if {::File.exists?("#{node["taskwarrior"]["server"]["home"]}/server.cert.pem")}
  notifies :run, "bash[Generating Server Cert]", :immediately
end

bash "Generating Server Cert" do
  user "root"
  cwd node["taskwarrior"]["server"]["home"]
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


