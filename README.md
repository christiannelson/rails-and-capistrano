# Rails And Capistrano

Sample project that illustrates using Capistrano to deploy a simple Ruby and Rails application to an Ubuntu server.

Can't use Heroku or you're curious what a straightforward server setup might look like? You'd like to think there was only one right way to do this, but a couple of google searches later shows that there are many. This project aims to show a simple approach that covers the important points.

This does not _require_ a cloud or physical server. A Vagrantfile and Ansible playbook are included so that you can easily provision a deploy target without any 3rd party services.

**Details**
* Ubuntu Server 14.04.1
* Ansible script for provisioning Ubuntu as a web/app/db server
* PostgreSQL 9.3 Database
* Nginx web server (configured to serve static assets)
* Ruby 2.1.2 installed via apt-get
* Unicorn application server (configured for zero-downtime deploys)
* Simple Rails 4.1 Application (generated using [raygun](https://github.com/carbonfive/raygun) with slight mods)
* Capistrano 3 deployment configuration

# Getting Started

This project includes automation so that setting up requires only a few (hefty) steps. If the prerequisites are met,
each step should execute without error. If there's an error, stop and correct before moving on to the next step.

## 1. Git Clone

1. ``git clone git@github.com:christiannelson/rails-and-capistrano.git``
1. ``cd rails-and-capistrano``
1. ``bundle``

## 2. Create and Provision a Server with Vagrant

We need a 'machine' to deploy to. Rather than spin up a cloud server, this project includes a Vagrant file and Ansible
playbook with detailed provisioning instructions. It's worth noting that Vagrant is only used here for convenience, in the real world, we would deploy to the cloud or some remote server. Though, parts of the Ansiable script would still apply.

**Prerequisites**

1. [Vagrant](https://www.vagrantup.com/) (tested with v1.6.3)
1. [Virtual Box](https://www.virtualbox.org/) (tested with v4.3.14)

**Instructions**

1. ``vagrant box add ubuntu-trusty https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box``
1. ``vagrant up``

This will take a while. It's spinning up a new vm and then using Ansible (see [playbook.yml](provisioning/playbook.yml))
to provision the new virtual machine. Basically, it's installing all of the foundational software, updating
system configuration, creating users, and generally getting the machine ready to be a Rails application server, web server, and database server.

## 3. Deploy the Application using Capistrano

``bundle exec cap staging deploy``

This also takes a while and is very verbose, at the end though, there will be a message that suggests it deployed the
master branch correctly.

## 4. Poke Around

Open [http://192.168.50.100](http://192.168.50.100). You should see a large "Hello, World!" greeting.

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

* ```RAILS_ENV``` - Rails environment to execute the application in (e.g. production, staging).
* ```SECRET_KEY_BASE``` - Secret key base for verifying signed cookies. Should be 30+ random characters and secret!
* ```DATABASE_URL``` - Connection information for the database.

**Optional**

* ```HOSTNAME``` - Canonical hostname for this application. Other incoming requests will be redirected to this hostname.
* ```BASIC_AUTH_PASSWORD``` - Enable basic auth with this password.
* ```BASIC_AUTH_USER``` - Set a basic auth username (not required, password enables basic auth).
* ```PORT``` - Port to listen on (default: 3000).
* ```UNICORN_WORKERS``` - Number of unicorn workers to spawn (default: development 1, otherwise 3).
* ```UNICORN_BACKLOG``` - Depth of unicorn backlog (default: 16).

### Third Party Services

...
