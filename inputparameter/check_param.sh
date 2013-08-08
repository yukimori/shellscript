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

exit 0