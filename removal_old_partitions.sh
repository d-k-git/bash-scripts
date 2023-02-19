# Delete files older than 3 years (~1098 days)

now=$(($(date +%s%N)/1000000))
tables=(sales)
for table in "${tables[@]}"
do
hdfs dfs -ls -R /database/${table}*  | grep "^d" | head -30 |  while read f;
do
partition_date=`echo $f | awk -F/ '{ print $4 }' | grep -v "^2000"`
directory=`echo $f |  awk '{print $8}'`
difference=$(( ($now -  $(($(date -d "$partition_date" +%s%N) / 1000000))) / (24 * 60 * 60 * 1000) ))
 if [ $difference -gt 1098  ]; then
    #echo $difference
    #echo $partition_date
    #echo $directory    
    hdfs dfs -rm -r $directory;
   fi
done
done
