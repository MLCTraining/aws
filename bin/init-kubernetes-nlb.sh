#!/bin/sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set -x									;
#########################################################################
test -n "${branch}"		|| exit 101                             ;
test -n "${domain}"		|| exit 103                             ;
test -n "${kube}"		|| exit 105                             ;
test -n "${os}"			|| exit 106                             ;
test -n "${path}"		|| exit 108                             ;
test -n "${port}"		|| exit 109                             ;
test -n "${repository}"		|| exit 110                             ;
test -n "${stack}"		|| exit 111                             ;
test -n "${username}"		|| exit 112                             ;
#########################################################################
function __send_list_command_remote { 					\
	_send_list_command_remote                                       \
		${branch}                                               \
		"${export}"                                             \
		${file}                                                 \
		${log}                                                  \
		${path}                                                 \
		${sleep}                                                \
		${stack}                                                \
		"${targets}"                                            \
		${url}                                                  \
                                                                        ;
}
#########################################################################
sleep=10								;
#########################################################################
url=${domain}/${username}/${repository}					;
#########################################################################
for instance in 							\
	InstanceMaster1 						\
	InstanceMaster2 						\
	InstanceMaster3 						\
									;
do 									\
	eval ${instance}="$(                                            \
                aws ec2 describe-instances                              \
                        --filters                                       \
        Name=tag:"aws:cloudformation:stack-name",Values="${stack}"      \
        Name=tag:"aws:cloudformation:logical-id",Values="${instance}"   \
                        --query                                         \
                        Reservations[].Instances[].PrivateIpAddress     \
                        --output                                        \
                                text                                    \
        )"								;
done									;
#########################################################################
service=docker 								;
targets="                                                               \
        InstanceWorker1                                                 \
        InstanceWorker2                                                 \
        InstanceWorker3                                                 \
"									;
#########################################################################
file=install-${service}-${os}.sh					;
log=/tmp/${file}.log							;
#########################################################################
export="                                                                \
        export kube=${kube}                                             \
"                                                                       ;
#########################################################################
__send_list_command_remote						;
#########################################################################
service=kube-nlb							;
targets="                                                               \
        InstanceWorker1                                                 \
        InstanceWorker2                                                 \
        InstanceWorker3                                                 \
"									;
#########################################################################
file=install-${service}.sh						;
log=/tmp/${file}.log							;
#########################################################################
export="                                                                \
        export InstanceMaster1=${InstanceMaster1}                       \
        &&                                                              \
        export InstanceMaster2=${InstanceMaster2}                       \
        &&                                                              \
        export InstanceMaster3=${InstanceMaster3}                       \
        &&                                                              \
        export kube=${kube}                                             \
        &&                                                              \
        export port=${port}                                             \
"                                                                       ;
#########################################################################
__send_list_command_remote						;
#########################################################################
