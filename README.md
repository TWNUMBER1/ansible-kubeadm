# ansible-kubeadm

### First time using ansible?
```sh
make depend_ubuntu // to setup environment
```
### Steps to deploy kubernetes cluster

1. Setup cluster list in inventories/myInventory, also your ssh key 
1. Ping first to make sure you can connect to target nodes
  ```sh
  make ping
  ```
1. Deploy by

  ```sh
  make deploy
  ```
