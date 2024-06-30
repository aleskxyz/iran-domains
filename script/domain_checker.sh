#!/bin/bash

input_file="$1"
max_concurrent="$2"

check_tls13() {
  domain=$1
  if curl --max-time 2 -sI --tlsv1.3 https://$domain > /dev/null 2>&1; then
    echo $domain
  fi
}

export -f check_tls13

parallel -j $max_concurrent check_tls13 :::: $input_file
