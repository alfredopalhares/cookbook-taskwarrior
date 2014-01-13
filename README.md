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
</table>

Usage
-----
#### taskwarrior::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `taskwarrior` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[taskwarrior]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors:
 - Alfredo Palhares (masterkorp@masterkorp.net)
