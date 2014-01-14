taskwarrior Cookbook
====================

Installs and configures taskwarrior client and server software.

Requirements
------------
All the requirements are installed for you if you use [Berkshelf](http://berkshelf.com/). Altough it is
good practice to add the following to the role run list.

#### cookbooks
- `apt` - To install the lastest packages.
- `git` - To clone the code both for client and server source installs.
- `cmake` - Build dependency for task and taskserver.
- `build-essential` - Build dependency for task and taskserver.
- `perl` - Build dependency for taskserver.
- `python` - Build dependency for taskserver.
- `runit` - To manage the taskserver daemon.

Attributes
----------

#### taskwarrior::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['taskwarrior']['method']</tt></td>
    <td>String</td>
    <td>Choose to install from the repository of from the lastest on the git repository</td>
    <td><tt>package</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["source"]["git_repository"]</tt></td>
    <td>String</td>
    <td>The git repository to clone taskwarrior from.</td>
    <td><tt>git://tasktools.org/task.git</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["source"]["git_revision"]</tt></td>
    <td>String</td>
    <td>The git revision to build from, HEAD is lastest</td>
    <td><tt>HEAD</tt></td>
  </tr>
</table>

#### taskwarrior::server
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["git_repository"]</tt></td>
    <td>String</td>
    <td>The git repository to clone taskserver from.</td>
    <td><tt>git://tasktools.org/taskd.git</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["git_revision"]</tt></td>
    <td>String</td>
    <td>The git revision to build from, HEAD is lastest</td>
    <td><tt>HEAD</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["home"]</tt></td>
    <td>String</td>
    <td>The main directory for taskd</td>
    <td><tt>/var/lib/taskd</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["data_dir"]</tt></td>
    <td>String</td>
    <td>Taskd data directory</td>
    <td><tt>default["taskwarrior"]["server"]["home"]}/data</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["confirmation"]</tt></td>
    <td>String</td>
    <td>Determines whether certain commands are confirmed</td>
    <td><tt>on</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["extensions"]</tt></td>
    <td>String</td>
    <td>Fully qualified path of the taskd extension scripts. Currently there are none.</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["ip_log"]</tt></td>
    <td>String</td>
    <td>Logs the IP addresses of incoming requests.</td>
    <td><tt>on</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["log"]</tt></td>
    <td>String</td>
    <td>Logs the IP addresses of incoming requests.</td>
    <td><tt>/var/log/taskd.log</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["queue_size"]</tt></td>
    <td>Integer</td>
    <td>Size of the connection backlog.</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["request_limit"]</tt></td>
    <td>Integer</td>
    <td>Size limit of incoming requests, in bytes.</td>
    <td><tt>1048576</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["link"]</tt></td>
    <td>String</td>
    <td>The address of the taskd server followed by a colon and the por number.</td>
    <td><tt>localhost:6544</tt></td>
  </tr>
  <tr>
    <td><tt>["taskwarrior"]["server"]["initialized"]</tt></td>
    <td>Boolean</td>
    <td>Used by the recipe to run the database creation only at first run. *Do not override*</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----

#### taskwarrior::default

Installs the taskwarrior client that can work standalone, just add it to your run_list. You can choose to install from the repositories,
or to build from source. Just set the ["taskwarrior"]["install_method"] to "source", like so.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[taskwarrior]"
  ]
  "override_attrubutes": {
    "taskwarrior": {
      "install_method": "source"
    }
  }
}
```

#### taskwarrior::server

Builds and installs the taskwarrior service daemon (taskd) and sets up supervising with runit. You need to create and set up the
server and client keys for it for the time being.
Check the taskwarrior wiki pages for [operation](http://taskwarrior.org/projects/taskwarrior/wiki/Taskserver_Operation), [setup](http://taskwarrior.org/projects/taskwarrior/wiki/Server_setup) amd [ciphers](http://taskwarrior.org/projects/taskwarrior/wiki/Ciphers)

Contributing
------------

The testing is done mostly with [test-kitchen](http://kitchen.ci/) before everything, set it up. Also [foodcritic](http://www.foodcritic.io/) is used for linting.

- Fork the repository on Github
- Create a named feature branch (like `add_component_x`)
- Write your change
- Make it pass foodcritic.
- Write tests for your change (if applicable)
- Run the tests, ensuring they all pass
- Submit a Pull Request using Github

License and Authors
-------------------
Authors:
 - Alfredo Palhares (masterkorp@masterkorp.net) and masterkorp on irc.freenode.org
