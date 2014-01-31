

default["taskwarrior"]["source"]["git_repository"] = "git://tasktools.org/task.git"
default["taskwarrior"]["source"]["git_revision"] = "HEAD"

default["taskwarrior"]["server"]["git_repository"] = "git://tasktools.org/taskd.git"
default["taskwarrior"]["server"]["git_revision"] = "HEAD"
default["taskwarrior"]["server"]["home"] = "/var/lib/taskd"
default["taskwarrior"]["server"]["data_dir"] = "#{default["taskwarrior"]["server"]["home"]}/data"
default["taskwarrior"]["server"]["keys_dir"] = "#{default["taskwarrior"]["server"]["home"]}/keys"

default["taskwarrior"]["server"]["confirmation"] = "on"
default["taskwarrior"]["server"]["extensions"] = ""
default["taskwarrior"]["server"]["ip_log"] = "on"
default["taskwarrior"]["server"]["log_dir"] = "/var/log/taskd"
default["taskwarrior"]["server"]["log_file"] = "#{default["taskwarrior"]["server"]["log_dir"]}/taskd.log"
default["taskwarrior"]["server"]["queue_size"] = 10
default["taskwarrior"]["server"]["request_limit"] = 1048576
default["taskwarrior"]["server"]["link"] = "localhost:6544"
