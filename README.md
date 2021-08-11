# Geni_test


This Repo is for all of the currnet tooling that I am using to build out a test bed for the Fabric project.

  
'GENI_TO_FABRIC_SAMPLE_NETWORK_Xgb.xml' is the test spec I used to test and set a standard for install.sh. 
  
  There are two versions of the Spec one with 16gb of ram the other 8gb of ram. 
  This is labeled in the file name.
  
There are five current folders, each containing ansible scripts and config files.

To use the scripts serveral edits must be made currently.
Changes must be made in each .yml file, to point to the correct ELK IP address.
In each .yaml file the current version and local user need to be updated as well.
In install.yaml, the elk username and password need to be set.
(install.sh is depreciated)

  
  # TODO
    - Working on pulling info from host file
    - Updating all dependencies


  # How to run
    Things to upload

  - Pubkey to all nodes for ssh
  - priv key to elk and install node
    - set chmod 600 on keys

  - install node things to upload:
    - mnt full space (https://groups.geni.net/geni/wiki/HowTo/IGGetExtraDIskSpace)
    - ELK_Stack.service
    - install.yaml
    - install host file

  - meas node things to upload:
    - usrnode host file
    - InstalltoRunnning.yaml('s) and there respective service files

  - Use multi-site
    - four per 4

    https://stackoverflow.com/questions/50277495/how-to-run-an-ansible-playbook-with-a-passphrase-protected-ssh-private-key


  issues running out of storage rapidly


  to be able to see the size: curl -XGET 'pcvm1-2.instageni.colorado.edu:9200/_cat/allocation?v&pretty'

  other info: https://www.elastic.co/guide/en/elasticsearch/reference/1.6/cluster-nodes-stats.html
   
   #eval "$(ssh-agent -s)"

   #ssh-add ~/.ssh/id_geni_ssh_rsa