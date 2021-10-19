#!/bin/sh
for ref in $(cat ./refs/sources.txt); do git clone $ref plugins/$(echo $ref | awk -F'[/@.]' '{ print $4 }'); done
