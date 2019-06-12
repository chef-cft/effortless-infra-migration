# effortless_infra_migration
Migration tool for moving from omnibus to effortless patterns of Chef-Infra.
=======

Migration tool for moving from an omnibus install of Chef Infra Client to the Effortless patterns.

# Models
## Habitat Distributed
In this model, the binaries for the Chef Infrastructure Client are distributed as a Chef Habitat package.  They are installed, and binlinked into the OS.  This allows customers to utilize the Chef Habitat packages with no other changes to their environment.  They can execute `chef-client` in the same way they always have.  This gives the advantage of an easier upgrade path due to the nature of Chef Habitat - upgrading is as easy as:
```shell
hab pkg install chef/chef-client
hab pkg binlink -force chef/chef-client
```
These can be done manually or via any automation tool -- including Chef Infra Client.  It can be done without worry of breaking things, as the binaries are self-contained with all of their required dependencies via Chef Habitat.
This does not include running the Chef Habitat Supervisor, and therefore does not give any of the advantages that brings, such as channel upgrades, automatic upgrade via strategy, Service Discovery, Health Checks, or similar.

## Habitat Supervised
In this model, the Chef Infra Client is executed via the Chef Habitat Supervisor.  This removes the need for an OS-specific init system, and is the first real step towards treating a customers' infrastructure as an application artifact.  This allows customers to follow the channel upgrade methodology, and build in easy testing and upgrades at scale into their existing CI/CD process.
This model allows customers to consume Chef Infra Server and their existing Cookbook CI process without significant change.  It allows customers to spend time transitioning their applications info Chef Habitat, and focus on minimizing their Chef Infra code, so that they can move towards the full Effortless Config model.  It is expected that most Enterprise Customers will spend some time in a hybrid world under this model.

## Effortless Config
In this model, the Chef Infra Client and all configuration is packaged as a Chef Habitat artifact.  This is the end-state of treating your infrastructure as an application.  In this model, only the most basic OS-level configuration and hardening is done via the Chef Infra Client.  No Chef Infra Server is required - the content is completely contained within the Chef Habitat artifact. This allows infrastructure to be viewed more simply, and tested more completely, ultimately increasing the velocity and safety our customers experience.
This requires customers to have well-formed CI/CD strategies, as well as a well defined storage model.  It is assumed that most Enterprise Customers will have several Application Cookbooks that will prevent them from fully embracing this model quickly; however, it is the model that all customers should be driving towards.

# Usage

```
git clone effortless_infra_migration

cd effortless_infra_migration

kitchen test distributed
kitchen test supervised
kitchen test managed
```


TODO:

* windows chef-client habitat package on builder
* windows support within the cookbook
* policyfile generator
