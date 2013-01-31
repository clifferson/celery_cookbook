# How do you want to install celery, pip or source?
default[:celery][:install_type] = 'pip' # 'pip', 'source' & 'development' are the options
default[:celery][:version]      = nil # leave as nil for latest when using pip or provide a version for pip. Mandatory for install_type source

# Source install bits
default[:celery][:source][:extension] = 'tar.gz'
default[:celery][:source][:url]       = 'http://pypi.python.org/packages/source/c/celery'
default[:celery][:source][:checksum]  = nil # Mandatory for install_type source use shasum -a 256 celery-version.tar.gz to generate

# Development install
default[:celery][:development][:repository] = 'git://github.com/celery/celery.git'
default[:celery][:development][:reference]  = 'master'

# Worker install
default[:celery][:worker][:install_location] = nil
default[:celery][:worker][:repository]       = nil
default[:celery][:worker][:reference]        = 'master'
