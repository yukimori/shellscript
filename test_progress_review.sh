#!/usr/bin/env bash

dot="....."

for i in `seq 5`
do
	printf "%s\r" $(echo ${dot:0:${i}})
	sleep 1
done

for i in `seq 5`
do
	printf "\r%s" `date "+%H:%M:%S"`
	sleep 1
done
echo
