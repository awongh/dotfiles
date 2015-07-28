/usr/local/bin/growlnotify -m 'Starting to backup stuff for backup. (＠_＠;)'
sudo ls -la /applications > ~/cronbackup/applications.txt
sudo cp -R /usr ~/cronbackup
sudo cp -R /opt ~/cronbackup
/usr/local/bin/growlnotify -m 'Finished backing up stuff for backup. (￣ー￣)'
