# Geni_test


This Repo is for all of the currnet tooling that I am using to build out a test bed for the fabric project.

install.sh is used to install all necessary tooling for the project testbed either on CentOS (7) or Ubuntu (20.04).

  syntax for install.sh: sudo ./install.sh $usr_name $usr_name_elk $password_elk 
  
  $usr_name is for the local user to be able to access the docker containers
  
  $usr_name_elk is for the user name to login into the elk stack
  
  $password is the password used to login into the elk stack
  
'GENI_TO_FABRIC_SAMPLE_NETWORK_Xgb.xml' is the test spec I used to test and set a standard for install.sh. 
  
  There are two versions of the Spec one with 16gb of ram the other 8gb of ram. 
  This is labeled in the file name.

# -----------------------------------------------------------------------------
# Copyright (c) 2020 University of Kentucky
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
