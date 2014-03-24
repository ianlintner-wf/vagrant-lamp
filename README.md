Vagrant LAMP
============

My default LAMP development stack configuration for Vagrant.

Installation:
-------------

Download and install [VirtualBox](http://www.virtualbox.org/)

Download and install [vagrant](http://vagrantup.com/)

Download a vagrant box (name of the box is supposed to be precise64)

    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box

Clone this repository

Go to the repository folder and launch the box

    $ cd [repo]
    $ vagrant up

What's inside:
--------------

Installed software:

* Apache
* MySQL
* php
* X phpMyAdmin
* Xdebug with Webgrind
* zsh with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* git, subversion
* mc, vim, screen, tmux, curl
* [MailCatcher](http://mailcatcher.me/)
* [Composer](http://getcomposer.org/)
* Phing
* Drupal utils:
    * [Drush](http://drupal.org/project/drush)
* X Wordpress utils:
    * X [WP-Cli](http://wp-cli.org/)
    * X [wp2github.py](http://github.com/r8/wp2github.py)
* X Magento utils:
    * X [n98-magerun](https://github.com/netz98/n98-magerun)
    * X [modman](https://github.com/colinmollenhour/modman)
    * X [modgit](https://github.com/jreinke/modgit)
* X Node.js with following packages:
    * X [CoffeeScript](http://coffeescript.org)
    * X [Grunt](http://gruntjs.com/)
    * X [Bower](http://bower.io)
    * X [Yeoman](http://yeoman.io)
    * X [LESS](http://lesscss.org)
    * X [CSS Lint](http://csslint.net)

Notes
-----

### Apache virtual hosts

You can add virtual hosts to apache by adding a file to the `data_bags/sites`
directory. The docroot of the new virtual host will be a directory within the
`public/` folder matching the `host` you specified. Alternately you may specify
a docroot explicitly by adding a `docroot` key in the json file.

### MySQL

The guests local 3306 port is available on the host at port 33066. It is also available on every domain. Logging in can be done with username=root, password=vagrant.

### phpMyAdmin

phpMyAdmin is available on every domain. For example:

    http://local.dev/phpmyadmin

### XDebug and webgrind

XDebug is configured to connect back to your host machine on port 9000 when 
starting a debug session from a browser running on your host. A debug session is 
started by appending GET variable XDEBUG_SESSION_START to the URL (if you use an 
integrated debugger like Eclipse PDT, it will do this for you).

XDebug is also configured to generate cachegrind profile output on demand by 
adding GET variable XDEBUG_PROFILE to your URL. For example:

    http://local.dev/index.php?XDEBUG_PROFILE

Webgrind is available on each domain. For example:

    http://local.dev/webgrind

It looks for cachegrind files in the `/tmp` directory, where xdebug leaves them.

**Note:** xdebug uses the default value for xdebug.profiler_output_name, which 
means the output filename only includes the process ID as a unique part. This 
was done to prevent a real need to clean out cachgrind files. If you wish to 
configure xdebug to always generate profiler output 
(`xdebug.profiler_enable = 1`), you *will* need to change this setting to 
something like
 
    xdebug.profiler_output_name = cachegrind.out.%t.%p
    
so your call to webgrind will not overwrite the file for the process that 
happens to serve webgrind. 

### Mailcatcher

All emails sent by PHP are intercepted by MailCatcher. So normally no email would be delivered outside of the virtual machine. Instead you can check messages using web frontend for MailCatcher, which is running on port 1080 and also available on every domain:

    http://local.dev:1080

### Composer

Composer binary is installed globally (to `/usr/local/bin`), so you can simply call `composer` from any directory.

### Drupal Virtual Hosts
Create a virtual hosts file in /etc/apache2/sites-available

	sudo nano site.local

	<VirtualHost *:80>
    	DocumentRoot /var/sites/site
    	ServerName site.local
    	RewriteEngine On
    	RewriteOptions inherit
    	CustomLog /var/log/apache2/site.log combined
	</VirtualHost>


### Enable the site
 sudo a2ensite site

### Reload apache2
 sudo /etc/init.d/apache2 reload
 
### Database Connection
Connect via ssh tunnel

	ssh ip: 192.168.32.42
	username: vagrant
	password: vagrant
	
	mysql ip: 127.0.0.1
	username: root
	password: vagrant

### Up PHP Memory Limit
	sudo sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php5/apache2/php.ini