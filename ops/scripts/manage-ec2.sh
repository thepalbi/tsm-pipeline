#!/bin/bash

# Create SSH alias
# https://www.digitalocean.com/community/tutorials/how-to-create-an-ssh-shortcut

INSTANCE_NAME=TesisVM

EC2_INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query 'Reservations[].Instances[].InstanceId'|jq -r ".[0]")

ec2_query() {
    query=$1
    raw_query_result=`aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID|jq -r $query`
    echo $raw_query_result
}

ec2_instance_status() {
    ec2_query '.Reservations[0].Instances[0].State.Name'
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

start_instance() {
    echo Starting instance named $INSTANCE_NAME, EC2InstanceID: $EC2_INSTANCE_ID
    if [[ "`ec2_instance_status`" == "running" ]]; then
        public_dns=$(ec2_query '.Reservations[0].Instances[0].PublicDnsName')
        echo "Instance already running! PublicDNS: $public_dns"
        exit 0
    fi
    
    aws ec2 start-instances --instance-ids $EC2_INSTANCE_ID
    wait_for_instance
}

usage() {
    cat << EOF
usage: manage-ec2.sh -[s|e|h]

-s: Start EC2 instance
-e: Get EC2 instance status
-h: Get help
EOF
}

while getopts ":seh" flag; do
    case "${flag}" in
        s)
            start_instance
        ;;
        e)
            echo "Instance named $EC2_INSTANCE_ID status: `ec2_instance_status`"
        ;;
        h | *)
            usage
        ;;
    esac
done

