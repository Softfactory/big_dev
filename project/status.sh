#!/bin/bash

for x in `cd /etc/init.d ; ls hadoop-*` ; do sudo service $x status; done
for x in `cd /etc/init.d ; ls hive-*` ; do sudo service $x status; done
for x in `cd /etc/init.d ; ls hbase-*` ; do sudo service $x status; done

