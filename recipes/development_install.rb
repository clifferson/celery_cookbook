include_recipe 'git'

git "/tmp/celery" do
  repository node[:celery][:development][:repository]
  reference node[:celery][:development][:reference] 
  action :sync
  notifies :run, "execute[build-celery]"
  notifies :run, "execute[install-celery]"
end

execute "build-celery" do
  command "python setup.py build"
  cwd "/tmp/celery"
  action :nothing
end

execute "install-celery" do
  command "python setup.py install"
  user "root"
  cwd "/tmp/celery"
  action :nothing
end
