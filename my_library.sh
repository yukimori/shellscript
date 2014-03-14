#!/bin/sh

#example
example() {
	echo "Hello World!"
}

#http://lambdalisue.hatenablog.com/entry/2013/07/06/023040
#起動スクリプトのパスを取得
getPathofScript() {
	ROOT=$(cd $(dirname $0); pwd)
	#返り値は数値しか返却できないのでの変わりに標準出力する
	echo "${ROOT}"
#	ROOT2=`dirname $0`
#	ROOT2=`cd $ROOT2;pwd`
#	echo "ROOT2 : ${ROOT2}\n"
}

#126
relpath2abs() {
	#if $1 is null
	if [ -z "$1" ]; then
		echo "usage: relpath2abs path"
		exit 1
	fi

	#check if $1 begins "/"
	if [ `expr x"$1" : x'/'` -ne 0 ]; then
		rel="$1" #$1 is abs path
	else
		rel="$PWD/$1" #$1 is rel path
	fi
	abs="/"
	IFS='/' #単語区切りを/にする
	for comp in $rel; do
		case "$comp" in
			'.'|'') # /./ // -> /
				continue ;
				;;
			'..')  #.. -> remove last element
				abs=`dirname "$abs"`
				;;
			*) #other
				[ "$abs" = "/" ] && abs="/$comp" || abs="$abs/$comp"
				;;
		esac
	done
	echo "$abs"
}

#relpath2abs ..

#文字列中のアルファベットを小文字に変換する
#アルファベットでないものは何もしない
downShift() {
	echo "$@" | tr '[A-Z]' '[a-z]'
}

#ホストが存在するかどうか判定する
checkHostname() {
	_PING=      #pingコマンドを使い分ける
	_HOST=${1:-`hostname`}
	
	case `uname -s` in
		FreeBSD ) _PING="ping -c1 $_HOST" ;;
		Linux ) _PING="ping -c1 $_HOST" ;;
		* ) return 1 ;;
	esac

	if [ `$_PING 2>&1 | grep -ci "Unknown host"` -eq 0 ]
		then
		return 0
		else
		return 1
	fi
}

#文字列が数値で構成されていれば0、数値以外が含まれていれば1を返却する
isNumeric() {
    if [ $# -ne 1 ]; then
	return 1
    fi

    expr "$1" + 1 > /dev/null 2>&1
    if [ $? -ge 2 ]; then
	return 1
    fi
    return 0
}

#文字列中の任意の単語を取り出す
wordsplit() {
    #setコマンドで引数の内容を単語に分割する
    ## --はそれ以降はオプションの解釈を行わないという指定
    set -- $1

    #結果を表示
    echo "Number of words: $#"
    echo "The fourth word: $4"
}

#環境変数が定義されているかどうかチェックする
#定義されている場合は値を表示し、定義されていない場合はnoneを表示する
exists_env_var() {
    env_var=$(eval echo '$'${1})
    if [ x${env_var:-""} = x ]
    then
#	echo ${1} " : none"
	return 1
    else
#	echo ${1} " : " ${env_var}
	return 0
    fi
}

#環境変数が定義されているかどうかチェックする
#定義されている場合は値を表示し、定義されていない場合はnoneを表示する
#指定した環境変数名を取得する手段が見つからない
exists_env_var2() {
    if [ x${1:-""} = x ]
    then
	echo "Environment variable : none"
    else
	echo "Environment variable : " ${1}
    fi
    return 1
}

#環境変数が定義されているかどうかチェックする
#定義されている場合は値を表示し、定義されていない場合はnoneを表示する
exists_env_var3() {
    env_var=$(printenv $1)
    if [ x${env_var:-""} = x ]
    then
	echo ${1} " : none"
    else
	echo ${1} " : "  ${env_var}
    fi
    return 1
}

#環境変数が定義されているかどうかチェックする
#空で定義されているときも定義されていると見なして処理をする
is_defined() {
    varname="$1"
    if set | grep -q "^${varname}="; then
	echo "${varname} is defined. "
	echo $(printenv $1)
    else
	echo "${varname} is NOT defined."
    fi
}

#環境変数が定義されているかどうかチェックし、
#定義されていれば表示、定義されていないときはnoneを表示する
is_envvar_defined() {
	varname=${1}
	info=`eval echo '$'${varname}`
	if [ x${info:-""} = x ]
	then
		echo "not defined."
		return 1
	else
		echo $info
		return 0
	fi
}

#ファイルの更新日付を調べる
print_updatetime() {
    set -- `ls -l -d "$1"`
    
    #分解結果
    #$1 アクセス権
    #$2 ハードリンク数
    #$3 所有ユーザ
    #$4 所有グループ
    #$5 サイズ
    #$6 最終更新日「月」
    #$7 最終更新日「日」
    #$8 最終更新日「年」もしくは「時：分」
    #$9以降 ファイル名

    month=`printf '%02d' $6` #01-12
    day=`printf '%02d' $7` #01-31

    echo "$month : $day"
}

#iノード番号を調べる
investigate_inode() {
    #lsの出力を単語に分解
    set -- `ls -i -d "$1"`
    #分解結果
    # $1 - iノード番号
    # $2以降 - ファイル名
    
    #iノード番号を表示
    echo "$1"
}

#setの調査
examin_set() {
    echo `ls -ai`
    set `ls -ai`
    echo '$1 : ' ${1}
}

#UnitTestCase
testNormalEnd()
{
    exists_env_var "http_proxy"
    rtrn=$?
    #http_proxyは設定されている前提で0であるはず
    assertEquals ${rtrn} 0
}

example

#execute UnitTestCase
#. shunit2

# echo "Examination..."
# examin_set
# wordsplit "I can fly from this floor."

# echo "Test Methods..."
# print_updatetime "test.sh"
# investigate_inode "test.sh"

# echo "Environment variable checks..."
# exists_env_var "http_proxy"
# exists_env_var2 "$http_proxy"
# exists_env_var3 "http_proxy"
# is_defined "http_proxy"

# exists_env_var "CC_HOME"
# exists_env_var2 "$CC_HOME"
# exists_env_var3 "CC_HOME"
# is_defined "CC_HOME"