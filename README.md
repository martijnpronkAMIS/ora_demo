# Demo Enterprise Modules ora_profile implementation

This repo contains a demonstration of a simple database installation with Enterprise Modules's ora_profile. 
You'll need to provide the Puppetlabs Puppet Enterprise packages in vm-scripts (unpack puppet-enterprise-2017.3.4-el-7-x86_64.tar.gz there)
in addition to provide the Oracle software in modules/software/files.

This demo is based on the generic/centos7 as provided on Vagrant Cloud.

If you like to use Enterprise modules in production, please contact Enterprise Modules at https://www.enterprisemodules.com/


## Starting the node

This example runs the Enterprise modules ora_profile with a masterless puppet environment. There are two examples,
one without patches (ora-db122) and the other includes the latest oracle patches (april 2018), ora-db122p

```
$ vagrant up <ora-db122|ora-db122p>
```

