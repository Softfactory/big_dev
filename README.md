# Deploying Pseudo Distributed Mode with CDH4 & R

## Requirements
  1. OS - Ubuntu Precise
  2. Virtual Box - 4.2.10
  3. Vagrant - 1.4.3

## Mode
  Pseudo Distributed

## Intallation Package List

  Oracle JDK 7

  CDH4 - hadoop(Yarn, MRv2),  hbase, hive

  MariaDB

  R - RHive

  R Studio

## Usage
### Install VirtualBox & Vagrant first.
$> vagrant up
### When oracle-java-installer fails.
$> vagrant provision
### It will take a long time. (~ 3 hr)
### Did you meet a problem, comment out some modules in base.pp & retry
$> vagrant provision

## Test Bid_Dev
### Hadoop MR
$> hadoop fs -mkdir input

$> hadoop fs -put /etc/hadoop/conf/*.xml input

$> hadoop fs -ls input

$> hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar pi 10 10

### HBase
$> hbase shell

$> hbase > create 't1', {NAME => 'f1', VERSIONS => 5}

### Hive
$> hive
hive> create table hbase_users (key string, v01 string, v02 string, v03 string)

stored by 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'

with serdeproperties ('hbase.columns.mapping'=':key,n:v01,n:v02,n:v03')

tableproperties ('hbase.table.name'='hly_tmp2');

### R
$> R

R> library(RHive)

R> rhive.init(hiveHome="/etc/hive", hiveLib="/usr/lib/hive/lib", hadoopHome="/etc/hadoop", hadoopConf="/etc/hadoop/conf",
       hadoopLib="/usr/lib/hadoop/lib", verbose=FALSE)

R> rhive.connect()


