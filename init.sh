#!/bin/bash

# This script is used to initialize the environment for the project.
service ssh start
hdfs namenode -format
hdfs namenode & hdfs datanode