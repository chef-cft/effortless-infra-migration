# chef-client-hab-distro

Cookbook to distribute habitat package chef-client to all currently legacy bootstrapped chef-client managed nodes.

# Usage

```
git clone chef-client-hab-distro

cd chef-client-hab-distro

kitchen create

chef-run IP install-chef-local

validate chef installed

chef-run IP chef-client-hab-distro

validate chef is hab managed
```


TODO:

* windows chef-client habitat package on builder
* policyfile for all dependencies
