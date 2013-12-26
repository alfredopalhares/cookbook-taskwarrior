default["taskwarrior"]["install_method"] = "package"

default["taskwarrior"]["source"]["git_repository"] = "git://tasktools.org/task.git"
default["taskwarrior"]["source"]["git_revision"] = "HEAD"

default["taskwarrior"]["server"]["git_repository"] = "git://tasktools.org/taskd.git"
default["taskwarrior"]["server"]["git_revision"] = "HEAD"
default["taskwarrior"]["server"]["home"] = "/var/lib/taskd"
default["taskwarrior"]["server"]["data_dir"] = "#{default["taskwarrior"]["server"]["home"]}/data"
