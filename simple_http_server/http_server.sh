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
  local message_arr=("$@")
  local request_method="${message_arr[0]}"
  local request_path="${message_arr[1]}"
  local request_version="${message_arr[2]}"
  local resource_path=$(resource_path_by_request_path $request_path)
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

function standardize_request_first_line () {
  local components=($1)
  local request_method="${components[0]}"
  local request_path="${components[1]}"
  local request_version="${components[2]}"

  # Support HTTP/[1.0, 1.1] only for now:
  if !([[ "$request_version" =~ ^HTTP\/[1][.][01]$ ]])
  then
    request_version="HTTP/1.1"
  fi
  # TODO: validate version
  # TODO: customize response for request version

  echo "$request_method $request_path $request_version"
}

function server () {
  while true
  do
    local message_arr=()
    read first_line
    first_line=$(standardize_request_first_line "$first_line")
    message_arr+=($first_line)

    local request_incoming=true
    while $request_incoming
    do
      read line
      if [[ "${#line}" -eq 1 ]]
      then
        request_incoming=false
      else
        message_arr+=($line)
      fi
    done
    local request_method="${message_arr[0]}"

    if [[ $request_method == 'GET' ]]
    then
      get_response "${message_arr[@]}"
    else
      echo "HTTP/1.1 400 Bad Request"
    fi
  done
}

coproc SERVER_PROCESS { server; }

ncat -lkv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}