#!/bin/bash

#":abc"とするとabc以外のオプションはエラー処理を自ら記述することを意味する
#ab:c:でb,cは値を設定できる
while getopts ab:c: opts
do
	case $opts in
		a)
			echo "option is a"
			flg_a="TRUE"
			;;
		b)
			echo "option is b"
			flg_b="TRUE"
			value_b="$OPTARG"
			;;
		c)
			echo "option is c"
			flg_c="TRUE"
			value_c="$OPTARG"
			;;
		?)
			echo "no match"
			;;
	esac
done

if [ "$flg_b" = "TRUE" ]; then
	echo "option b value is $value_b"
fi

if [ ! -z "$flg_c" ]; then
	echo "option c value is $value_c"
fi

#getopt終了後はOPTINDがオプション部の直後を示しているのでOPTIND-1でオプション部を切り捨てることができる
shift `expr $OPTIND - 1`
#shift $(($OPTIND - 1))

#$1には先頭の引数が設定される
echo "input parameter is $1"
printf "Remaining arguments are : %s\n" "$*"

#関数にするとスクリプト実行時に指定したオプションを渡すことができない
#getoptsの部分で異常終了している？でもエラーはでない。
notuse_getoption() {
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

exit 0