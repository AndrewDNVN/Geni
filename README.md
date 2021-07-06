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

  
  # TODO
    - Working on pulling info from host file
    - Updating all dependencies


# -----------------------------------------------------------------------------
# Copyright (c) 2021 University of Kentucky
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and/or hardware specification (the "Work") to deal in the
# Work without restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Work, and to permit persons to whom the Work is furnished to do so,
# subject to the following conditions:# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Work.# THE WORK IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE WORK OR THE USE OR OTHER DEALINGS IN THE WORK.
# -----------------------------------------------------------------------------
