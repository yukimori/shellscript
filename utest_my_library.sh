#!/bin/sh

#document for shunit2
#https://sites.google.com/site/paclearner/shunit2-documentation

#テスト対象の読み込み
. ./my_library.sh

testGetPathofScript() {
	#関数の標準出力を取得して返り値とする
	ROOT=`getPathofScript`
	echo "ROOT : ${ROOT}\n"
}

testRelpath2abs() {
	assertNotEquals `relpath2abs ../..` "/"
}

testIsEnvVarDefined() {
	envvar="LANG"
	is_envvar_defined $envvar
	assertEquals `is_envvar_defined LANG` "ja_JP.UTF-8"
}

testDownShift() {
	assertEquals `downShift AAAAA` "aaaaa"
	assertNotEquals `downShift AAAAA` "AAAAA"
}

testCheckHostnameWithoutHostname() {
	checkHostname
	assertEquals $? 0
}

testCheckHostnameWithErrorHostname() {
	checkHostname "gt110s"
	assertEquals $? 1
}

testCheckHostname() {
	checkHostname "gt110"
	assertEquals $? 0
}

# testExist_env_var() {
#     exists_env_var "http_proxy"
#     rtrn=$?
#     #http_proxyは設定されている前提で0であるはず
#     assertEquals ${rtrn} 0
# }

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
