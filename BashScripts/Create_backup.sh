#!/bin/bash

echo "########################################" >> Create_backup.log
echo -e "---\nStart $(date '+%Y-%m-%d %H:%M:%S')" >> Create_backup.log
source=$1
dist=$2
n=${3:-3}
archFileName="$(date '+%Y%m%d-%H%M%S').tar.gz"
echo "archFileName $archFileName" >> Create_backup.log
if [[ ! -d $source && ! -f $source ]]
then
    echo "Source $source does not exist." >> Create_backup.log
else
    echo "Source $source found." >> Create_backup.log
    if [[ ! -d $dist || ! $dist ]]
    then
        echo "Distination directory $dist does not exist." >> Create_backup.log
    else
        echo "Distination $dist found." >> Create_backup.log
        if [ ! -d $dist/backup ]
        then
            echo "Distination directory $dist/backup does not exist." >> Create_backup.log
            echo "Create $dist/backup." >> Create_backup.log
            mkdir $dist/backup >> Create_backup.log 2>&1
        fi
        echo -e "---\nBackup" >> Create_backup.log
        tar -cvf $dist/backup/$archFileName $source >> Create_backup.log 2>&1
        echo -e "---\nDelete files > $n" >> Create_backup.log
        while [ `ls ~/backup | wc -l` -gt $n ]
        do
            olderFile=`ls -1rt ~/backup | head -1`
            echo "OlderFile $olderFile." >> Create_backup.log 2>&1
            rm -f $dist/backup/$olderFile
        done
    fi
fi
echo -e "---\nStop $(date '+%Y-%m-%d %H:%M:%S')" >> Create_backup.log