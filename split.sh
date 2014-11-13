#!/bin/bash

set -u
set -e


split() {
	sep=$1
	str=$2

	_split=()
	if [[ $str =~ $sep ]]; then
		while IFS= read -r e;do
			_split+=("$e")
			declare -p e
		done < <(echo "${str//$sep/$'\n'}")
	fi
}

split ':' 'foo:bar:baz'
#変数の状態を表示する
declare -p _split
echo ">${_split[0]}<"
