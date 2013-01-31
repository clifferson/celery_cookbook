# TODO how can this be all SVC instead of just git?
worker_install_location = node[:celery][:worker][:install_location]
worker_repository       = node[:celery][:worker][:repository]
worker_reference        = node[:celery][:worker][:reference]

Chef::Application.fatal!("node[:celery][:worker][:install_location] needs to be set for celery::worker", 101)
Chef::Application.fatal!("node[:celery][:worker][:repository] needs to be set for celery::worker", 102)


directory worker_install_location do
  recursive true
end

include_recipe 'git' 

git worker_install_location do
 repository worker_repository
 reference worker_reference
 action :sync
end

execute "celery-worker" do
  command "celery -A tasks worker &"
  cwd worker_install_location
end

