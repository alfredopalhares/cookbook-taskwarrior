#
# Cookbook Name:: taskwarrior
# Recipe:: default

# Make sure the local repositores are up to date.
include_recipe "apt"

package "task"
