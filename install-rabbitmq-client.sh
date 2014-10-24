#!/bin/bash

set -x 

pushd /home/vagrant > /dev/null 2>&1 
tar xvf /vagrant/rabbitmq-java-client-bin-3.4.0.tar.gz > /dev/null 2>&1
popd > /dev/null 2>&1
