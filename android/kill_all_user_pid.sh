#!/usr/bin/env bash

PIDS="$(ps -ef|grep u0|awk '{print $2}')"

for i in ${PIDS}; do
    kill -9 $i
done
