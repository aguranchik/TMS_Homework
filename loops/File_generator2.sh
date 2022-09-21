# Парамерт 1 - папка назначения
# Параметр 2 - глубина
# На первом уровне создается одна папка, чтобы не засорять папку назначения
# На каждом из сделующих уровней рандомное числ папок и файлов
# На последнем уровне создаются только файлы

#!/bin/bash

mkd() {
    local rndFile=$(( RANDOM % 9 + 1))
    local rndDir=$(( RANDOM % 9 + 1))
    local deep=$(( $2 - 1 ))
    if [ $2 -le 0 ]
    then
        return
    else
        while [ $rndDir -gt 0 ] && [ $deep -gt 0 ]
        do           
            nameDir="$1/Level$deep""-""$rndDir"
            mkdir -v $nameDir >> File_generator2.log 2>&1
            mkd $nameDir $deep
            (( rndDir-- ))
        done
        while [ $rndFile -gt 0 ]
        do
            echo "$1/File-$rndFile.tst" >> File_generator2.log
            touch "$1/File-$rndFile.tst"  >> File_generator2.log 2>&1
            (( rndFile-- ))
        done
    fi
}

echo "########################################" >> File_generator2.log
echo -e "---\nStart $(date '+%Y-%m-%d %H:%M:%S')" >> File_generator2.log

dist=$1
deep=$2
if [[ ! -d $dist ]]
then
    echo "Dist $dist does not exist." >> File_generator2.log
else
    echo "Dist $dist found." >> File_generator2.log
    mkdir -v "$dist/Level$deep" >> File_generator2.log 2>&1
    mkd "$dist/Level$deep" $deep
fi
for file in `find $dist/Level$deep -type f`
do
  if [[ $(( ${file: -5:1} % 2 )) -eq 0 ]]
  then
    echo "even" > $file
    echo $file - "even" >> File_generator2.log 2>&1
  else
    echo "odd" > $file
    echo $file - "odd" >> File_generator2.log 2>&1
  fi
done