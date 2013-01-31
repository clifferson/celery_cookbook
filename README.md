# Description

Install python celery from pip, source or SCM (currently only supports git). 

If `celery::default` is used with no attributes set the latest version of celery from pip will be installed.

`celery::worker` is a bit dev focused and needs some love regarding starting/stoping workers. 

This cookbook can:
* Install celery from pip, source or git.
* Clone a git repo containing celery "tasks.py"
* Launch workers against the "tasks.py"

This cookbook will raise `fatal` exceptions when mandatory node attributes are not set.

# Requirements

#### cookbooks
* python
* git

# Attributes

#### Install options
* `node.celery.install_type` - pip, source & development are options. Development will install from a git repo/branch. default `pip`.
* `node.celery.version` - What version of celery to install. nil results in latest for pip. mandatory for install_type: source, not used for install_type: development. default `nil`.

#### Source install
* `node.celery.source.url` - Where to download the source ball from. default `http://pypi.python.org/packages/source/c/celery`.
* `node.celery.source.checksum` - Sha256 of the source ball located at node.celery.source.url. default `nil`.
* `node.celery.source.extention` - extention for the source ball. Currenty the recipe only supports tar. default `tar.gz`.

#### Development install
* `node.celery.development.repository` - Git repo to clone. Currently the recipe only supports git. default `git://github.com/celery/celery.git`.
* `node.celery.reference` - Git ref to clone. default `master`


#### Worker install & setup
* `node.celery.worker.install_location` - Direcotry to clone tasks.py repository into. default `nil`
* `node.celery.worker.repository` -  Git repo that contains tasks.py. default `nil`
* `node.celery.worker.reference` - Git ref to clone. default `master`

# Usage
#### celery::default
To install the latest version of celery from pip just include `celery` in your node's `run_list`.

Set `node.celery.install_type` to [pip, source, development] to change the install type. `celery::default` will include the correct install recipe.

#### celery::*_install
Not for inclusion in node run lists. `celery::default` will include the needed recipes based on `node.celery.install_type`

#### celery::worker
Use this recipe to clone your "tasks.py" git repo and start a worker associated with that task. This recipe is non idempotent and hacky only good for quick dev.

If you are deploying locally into a vagrant box you can use the config.vm.share_folder vagrant config option to expose your local tasks repo.

TODO Create an lwrp for starting workers and seperate repo cloning from worker starting.
TODO use an init script.

#### Worker install & setup
* `node.celery.worker.install_location` - Direcotry to clone tasks.py repository into. default `nil`
* `node.celery.worker.repository` -  Git repo that contains tasks.py. default `nil`
* `node.celery.worker.reference` - Git ref to clone. default `master`


# Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable) (Do as I say not as I do ;)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

# License and Authors

Authors: Cliff Erson (<him@clifferson.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
