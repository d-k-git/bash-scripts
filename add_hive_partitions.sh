#!/bin/sh

hql="ALTER TABLE mydb.mytable  ADD IF NOT EXISTS PARTITION (time_key=${part}) LOCATION 'hdfs://ns-etl/dbs/mydb/mytable/${part}'"

partitions=(20221007 20221008 20221009 20221010)
for part in ${partitions[@]}
  do 
hive -e "$hql"  
done

# sub partitions 
hql="ALTER TABLE mydb.mytable  ADD IF NOT EXISTS PARTITION (time_key=${part},region=${region})"
partitions=(20221007 20221008 20221009 20221010)
regions=(A B C D E F)
for part in ${partitions[@]}
do
  for region in ${regions[@]}
  do 
    hive -e "$hql"  > dbs/mydb/mytable"${region}/${part}"
  done
done  
  
