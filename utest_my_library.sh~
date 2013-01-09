#!/bin/sh

#テスト対象の読み込み
. ./test_shellscript.sh

testExist_env_var() {
    exists_env_var "http_proxy"
    rtrn=$?
    #http_proxyは設定されている前提で0であるはず
    assertEquals ${rtrn} 0
}

testIsNumeric() {
    isNumeric "1234"
    rtrn=$?
    assertEquals ${rtrn} 0
    isNumeric "1234aa"
    rtrn=$?
    assertEquals ${rtrn} 1
    isNumeric "1234" "5678"
    rtrn=$?
    assertEquals ${rtrn} 1
}

. shunit2