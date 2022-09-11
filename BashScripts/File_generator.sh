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
            mkdir -v $nameDir >> File_generator.log 2>&1
            mkd $nameDir $deep
            (( rndDir-- ))
        done
        while [ $rndFile -gt 0 ]
        do
            echo "$1/File-$rndFile.tst" >> File_generator.log
            touch "$1/File-$rndFile.tst"  >> File_generator.log 2>&1
            (( rndFile-- ))
        done
    fi
}

echo "########################################" >> File_generator.log
echo -e "---\nStart $(date '+%Y-%m-%d %H:%M:%S')" >> File_generator.log

dist=$1
deep=$2
if [[ ! -d $dist && ! -f $dist ]]
then
    echo "Dist $dist does not exist." >> File_generator.log
else
    echo "Dist $dist found." >> File_generator.log
    mkdir -v "$dist/Level$deep"  >> File_generator.log 2>&1
    mkd "$dist/Level$deep" $deep
 fi