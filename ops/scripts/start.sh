#!/bin/bash

# Create SSH alias
# https://www.digitalocean.com/community/tutorials/how-to-create-an-ssh-shortcut

INSTANCE_NAME=TesisVM

EC2_INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query 'Reservations[].Instances[].InstanceId'|jq -r ".[0]")

ec2_query() {
    query=$1
    raw_query_result=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --query $query)
    echo $raw_query_result|jq -r ".[0]"
}

ec2_instance_status() {
    ec2_query "Reservations[].Instances[].State.Name"
}

wait_for_instance() {
  echo "Waiting for instance $EC2_INSTANCE_ID to be ready"
  for (( i=1; i<=10; i++ ));do
    if [[ "$(ec2_instance_status)" == "running" ]]; then
      break
    else
      if ((i != 10)); then
        sleep 2
      else
        echo "The instance $EC2_INSTANCE_ID was not created after 20 secs."
        exit 1
      fi
    fi
  done
}

echo Starting instance named $INSTANCE_NAME, EC2InstanceID: $EC2_INSTANCE_ID 
if [[ "$(ec2_instance_status)" == "running" ]]; then
    public_dns=$(ec2_query 'Reservations[].Instances[].PublicDnsName')
    echo "Instance already running! PublicDNS: $public_dns"
    exit 0
fi

aws ec2 start-instances --instance-ids $EC2_INSTANCE_ID
wait_for_instance
