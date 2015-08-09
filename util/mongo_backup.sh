DATE=$(date +"%s")

NUM_BACKUPS=$(ls -lR | grep backup_ | grep ^d | wc -l)

MIN_BACKUPS=5

if [ "$NUM_BACKUPS" -lt "$MIN_BACKUPS" ]; then

    #Less than  MIN_BACKUPS backups, just create another
    echo "Creating a new backup...."
    mongodump --port 27017 --db datamining --out backup_$DATE;

else

    #remove oldest backup
    min=9999999999;

    for f in $(ls | grep backup_)
    do
        d=$(echo $f | cut -d'_' -f2)

        if [ "$d" -lt "$min" ]; then
            min=$d
        fi

    done

    echo "Removing old backup: backup_"$min

    rm -rf backup_$min

    # create a new backup in the old one's place.
    echo "Creating a new backup: backup_"$DATE
    mongodump --port 27017 --db datamining --out backup_$DATE;

fi

