# Rails And Capistrano

Sample Rails application that illustrates using Capistrano for deployment to a Vagrant VM.

**Details**
* Simple Rails 4.1 (generated using [raygun](https://github.com/carbonfive/raygun) with slight mods)
* PostgreSQL 9.3 Database
* Nginx web server (configured to serve static assets)
* Unicorn application server (configured for zero-downtime deploys)
* Ubuntu Server 14.04.1
* Ansible script for complete provisioning
* Capistrano 3 deployment configuration

# Getting Started

This project includes automation so that setting up requires only a few (hefty) steps. If the prerequisites are met,
each step should execute without error. If there's an error, stop and correct before moving on to the next step.

## 1. Git Clone

1. ``git clone git@github.com:christiannelson/rails-and-capistrano.git``
1. ``cd rails-and-capistrano``
1. ``bundle``

## 2. Create and Provision a Server with Vagrant

We need a 'machine' to deploy to. Rather than spin up a cloud vm, this project includes a Vagrant file and Ansible
configuration with detailed provisioning instructions.

**Prerequisites**

1. [Vagrant](https://www.vagrantup.com/) (tested with v1.6.3)
1. [Virtual Box](https://www.virtualbox.org/) (tested with v4.3.14)

**Instructions**

1. ``vagrant box add ubuntu-trusty https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box``
1. ``vagrant up``

This will take a while. It's spinning up a new vm and then using ansible (see [playbook.yml](provisioning/playbook.yml))
to provision the new virtual machine. Basically, it's installing all of the foundational software, updating
system configuration, creating users, and generally getting the machine ready to be a rails application server.

## 3. Deploy the Application using Capistrano

``bundle exec cap staging deploy``

This also takes a while and is very verbose, at the end though, you should see a message that suggests it deployed the
master branch correctly.

Open [http://localhost:2280](http://localhost:2280). You should see a large "Hello, World!" greeting.

# Server Environments

### Hosting

...

### Environment Variables

Several common features and operational parameters can be set using environment variables.

**Required**

* ```SECRET_KEY_BASE``` - Secret key base for verifying signed cookies. Should be 30+ random characters and secret!

**Optional**

* ```HOSTNAME``` - Canonical hostname for this application. Other incoming requests will be redirected to this hostname.
* ```BASIC_AUTH_PASSWORD``` - Enable basic auth with this password.
* ```BASIC_AUTH_USER``` - Set a basic auth username (not required, password enables basic auth).
* ```PORT``` - Port to listen on (default: 3000).
* ```UNICORN_WORKERS``` - Number of unicorn workers to spawn (default: development 1, otherwise 3).
* ```UNICORN_BACKLOG``` - Depth of unicorn backlog (default: 16).

### Third Party Services

...