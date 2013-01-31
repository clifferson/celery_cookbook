#
# Cookbook Name:: celery
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"
include_recipe "celery::#{node[:celery][:install_type]}_install"
