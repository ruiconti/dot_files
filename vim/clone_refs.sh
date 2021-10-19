#!/bin/sh
refs=./refs/sources.txt
output=bundles
for ref in $(cat $refs); do dirname=$(echo $ref | awk -F'[/@.]' '{ print $4 }') && test ! -d $output/$dirname && git clone $ref $output/$dirname; done
