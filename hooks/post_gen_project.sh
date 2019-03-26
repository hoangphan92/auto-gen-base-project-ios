#!/bin/sh

set -e

git init
bundle install
cd "{{ cookiecutter.project_name | replace(' ', '') }}"
bundle exec pod install


echo "------------ AUTO GENERATE SUCCESSFULLY ----------------"
project_path="$(pwd)/{{ cookiecutter.project_name | replace(' ', '') }}"
echo "- Your project path is: $project_path"
echo "------------ CREATED AND MANTAIN BY SHAW VU -------------"
