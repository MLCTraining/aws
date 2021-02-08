#!/bin/bash -x
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set -x
#########################################################################
file=common-functions.sh
path=lib
#########################################################################
source ./${path}/${file}
#########################################################################
file=init-${mode}.sh
HostedZoneName=sebastian-colomar.com
ip_leader=10.168.1.100
path=bin
#########################################################################
source ./${path}/${file}
#########################################################################
