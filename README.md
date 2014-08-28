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

## 4. Poke Around

This machine is configured so that all of the services restart after a reboot. The only tricky bit there is located in
``/etc/init.d/unicorn`` (on the vm).

During a ``cap staging deploy``, unicorn is reloaded in a manner that supports a zero-downtime deploy. You can run
apache bench, wrk, or siege and beat on the server through a deploy and (hopefully) see 0 errors or downtime.

Application settings are loaded via the environment. Check out ``/var/www/rails-and-capistrano/shared/configuration``
(on the vm) for the settings. Under normal circumstances, this file would be added by hand and not copied from version
control. This is a sample app and I optimized for the out of the box experience. These settings are loaded for unicorn
and for all capistrano commands.

Static assets are served by nginx instead of the application server.

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