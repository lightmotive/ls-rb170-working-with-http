#!/bin/bash

resource_root="./www"

function resource_path_by_request_path () {
  local request_path=$1
  local resource_sub_path=$request_path

  # Enable default file for '/' request path
  if [[ $request_path == '/' ]]
  then
    resource_sub_path="/default.html"
  fi

  echo "$resource_root$resource_sub_path"
}

function resource_content () {
  cat $1
}

function get_response () {
  local request_method=$1
  local request_path=$2
  local request_version=$3
  local resource_path=$(resource_path_by_request_path $request_path)

  if [[ -z $request_version ]]
  then
    request_version="HTTP/1.1"
  fi
  # TODO: validate version
  # TODO: customize response for request version

  local start_line="$request_version"

  if [[ -f $resource_path ]]
  then
    local start_line="$start_line 200 OK"
  else
    local start_line="$start_line 404 Not Found"
    local resource_path=$(resource_path_by_request_path '/not_found.html')
  fi

  local message_body=$(resource_content $resource_path)

  echo -ne "$start_line\r\n\r\n$message_body\r\n\r\n"
}

function server () {
  while true
  do
    read method path version
    # 

    if [[ $method == 'GET' ]]
    then
      get_response $method $path $version
    else
      echo "HTTP/1.1 400 Bad Request"
    fi
  done
}

coproc SERVER_PROCESS { server; }

ncat -lkv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}