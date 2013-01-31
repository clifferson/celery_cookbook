python_pip "celery" do
  action :install
  if node[:celery][:version]
    version node[:celery][:version]
  end
end
