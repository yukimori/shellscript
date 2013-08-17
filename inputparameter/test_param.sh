#!/bin/bash

#":abc"とするとabc以外のオプションはエラー処理を自ら記述することを意味する
while getopts 'abc' opts
do
	case $opts in
		a)
			echo "option is a"
			;;
		b)
			echo "option is b"
			;;
		c)
			echo "option is c"
			;;
		?)
			echo "no match"
			;;
	esac
done

#関数にするとスクリプト実行時に指定したオプションを渡すことができない
#getoptsの部分で異常終了している？でもエラーはでない。
getoption() {
	while getopts 'abc' opts
	do
		case $opts in
			a)
				echo "option is a"
				;;
			b)
				echo "option is b"
				;;
			c)
				echo "option is c"
				;;
			?)
				echo "no match"
				;;
		esac
	done
}

check_param() {
	if [ $# -ne 3 ]; then
		echo "指定された引数は$#個です。"  1>&2
		echo "実行するには3個の個数が必要です。" 1>&2
		exit 1
	fi
	
#ヒアドキュメントでメッセージを表示
	cat <<__EOT__
指定された引数は
$1
$2
$3
の$#個です。
__EOT__
}

getoption

exit 0