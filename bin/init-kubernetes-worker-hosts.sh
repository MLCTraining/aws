#!/bin/sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set -x                                                                  ;
#########################################################################
test -n "${kube}"               || exit 102                             ;
#########################################################################
file=/etc/hosts                                                         ;
#########################################################################
sudo sed --in-place                                                     \
        /${kube}/d                                                      \
        ${file}                                                         \
                                                                        ;
#########################################################################
