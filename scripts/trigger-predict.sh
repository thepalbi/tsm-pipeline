#! /bin/sh

set -e

# Trigger the predict.yml workflow using the GitHub CLI

if [ $# -ne 3 ]; then
    echo "Usage: ./trigger.sh <query> <training-projects> <test-projects>"
    exit 1
fi

query="$1"
training_projects="$2"
test_projects="$3"

# ensure size limitations: cannot have more than 256 training or test projects
if [ $(cat "$training_projects" | wc -l) -gt 256 ]; then
    echo "Too many training projects; maximum 256."
    exit 1
fi
if [ $(cat "$test_projects" | wc -l) -gt 256 ]; then
    echo "Too many test projects; maximum 256."
    exit 1
fi

list_to_json_array() {
    file="$1"
    cat "$file" | awk 'BEGIN { printf "["; sep=" " } { printf "%s\"%s\"", sep, $0; sep=", " } END { print " ]" }'
}

training_projects_json=`mktemp`
test_projects_json=`mktemp`

list_to_json_array "$training_projects" > "$training_projects_json"
list_to_json_array "$test_projects" > "$test_projects_json"

gh workflow run predict.yml \
    --field query_name="$query" \
    --field training_projects=@"$training_projects_json" \
    --field test_projects=@"$test_projects_json"

rm -f "$training_projects_json" "$test_projects_json"
