# Inception of Things

Make sure to install VirtualBox and Vagrant through the Managed Software Center.
When installed, run the following commands:

```shell script
mkdir -p ~/goinfre/VirtualBox\ VMs
rm -rf ~/VirtualBox\ VMs
ln -s ~/goinfre/VirtualBox\ VMs ~/VirtualBox\ VMs
# Symlink the volume where Virtualbox stores its giant files to the goinfre

vagrant plugin install vagrant-vbguest
# Install the vbguest plugin which is needed to run p1
```
