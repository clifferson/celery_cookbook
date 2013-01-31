version = node[:celery][:version]
celery_package_name = "celery-#{version}"

# build some file names and urls
source_repo_url = node[:celery][:source][:url]
source_extension = node[:celery][:source][:extension]
source_package = "#{celery_package_name}.#{source_extension}"
source_package_url = "#{source_repo_url}/#{source_package}"
source_package_checksum = node[:celery][:source][:checksum]

# TODO Why do I have to == nil? 
Chef::Application.fatal!("node[:celery][:version] must be set to use install_type 'source'", 100) if version == nil
Chef::Application.fatal!("node[:celery][:source][:checksum] must be set to use install_type 'source'", 101) if source_package_checksum == nil

# TODO You should be able to not need a checksum if you want to be an ass hat. nil?
remote_file "#{Chef::Config[:file_cache_path]}/#{source_package}" do
  source source_package_url
  checksum source_package_checksum
  mode 0644
  not_if "if [[ $(celery --version | awk '{print $1}') == '#{version}' ]]"
  notifies :run, "execute[unzip-celery]"
  notifies :run, "execute[build-celery]"
  notifies :run, "execute[install-celery]"
end

execute "unzip-celery" do
  command "tar xf #{Chef::Config[:file_cache_path]}/#{source_package} -C /tmp"
  action :nothing
end

execute "build-celery" do
  command "python setup.py build"
  cwd "/tmp/#{celery_package_name}"
  action :nothing
end

execute "install-celery" do
  command "python setup.py install"
  user "root"
  cwd "/tmp/#{celery_package_name}"
  action :nothing
  notifies :delete, "directory[/tmp/#{celery_package_name}]"
end

directory "/tmp/#{celery_package_name}" do
  action :nothing
  recursive true 
end 
