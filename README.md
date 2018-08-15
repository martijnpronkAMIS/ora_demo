# Demo Enterprise Modules ora_profile implementation

This repo contains a demonstration of a simple database installation with Enterprise Modules's ora_profile. 
You'll need to provide the Oracle software in modules/software/files.
There are two examples: one for Oracle 12.2 including patches and the other for Oracle 18.3

This demo is based on the generic/centos7 as provided on Vagrant Cloud.

If you like to use Enterprise modules in production, please contact Enterprise Modules at https://www.enterprisemodules.com/


## Starting the node(s)

### Oracle 12.2
This example runs the Enterprise modules ora_profile with a masterless puppet environment, it will include the April 2018 patches.


```
$ vagrant up ora-db122
```

### Oracle 18.3
This example will install Oracle 18.3 using ora_profile. There are no patches/updates yet for this version, so patching will be skipped.

```
$ vagrant up ora-db18c
```

## Seeing your results
When the puppet run is finished you may want to see your freshly created database: use
```
$ vagrant ssh ora-db18c
```
to connect to your host. Then use sudo to change to the user Oracle:
```
sudo su - oracle
```
By default the database name is DB01. In addition, port 1521 is exposed to your host at port 11521
