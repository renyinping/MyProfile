# /bin/bash

ARCHIVER_LIST=archiver_list.txt

# 归档
function my_archiver
{
	if [ -z "$1" ]; then
		echo 'usage: my_archiver <password>';
		return 1;
	fi;
	
	sed -i 's/\\/\//g' ${ARCHIVER_LIST};
	for i in $(cat ${ARCHIVER_LIST}); do
		./7z a "${i}.7z" -p${1} -mhe "${i}";
	done;
}

# 提取归档
function my_archiver_extract
{
	if [ -z "$1" ]; then
		echo 'usage: my_archiver <password>';
		return 1;
	fi;
	
	sed -i 's/\\/\//g' ${ARCHIVER_LIST};
	for i in $(cat ${ARCHIVER_LIST}); do
		./7z x ${i}.7z -p${1};
	done;
}
