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
