alias sudo='sudo env PATH=$PATH'
alias awlogin='ssh -p 6969 awh@wong.homelinux.net -v'
alias homewifi='sudo iwconfig eth1 essid "linksys" key 73DAFF339F'
alias foothill='ssh -v wongakir@losaltos.fhda.edu'
alias footftp='sftp wongakir@losaltos.fhda.edu'
footscp(){
	scp -v "$1" wongakir@losaltos.fhda.edu:public_html
}
footscp2(){
	scp -v "$1" wongakir@losaltos.fhda.edu:"$2"
}
footfolder(){
	scp -vr "$1" wongakir@losaltos.fhda.edu:"$2"
}
getfoot(){
	scp -v wongakir@losaltos.fhda.edu:"$1" .
}
getfootfolder(){
	scp -vr wongakir@losaltos.fhda.edu:"$1" .
}
alias wpsteel='cd /var/www/frontpage/wpdemo/demo2/wp-content/themes/steelman'
putaw(){
	scp -v "$1" awh@wong.homelinux.net:"$2"
}
putawfolder(){
	scp -vr "$1" awh@wong.homelinux.net:"$2"
}
alias dirtlog='ssh -v sfdirtadmin@72.167.232.226'
putdirt(){
	scp -v "$1" sfdirtadmin@72.167.232.226:"$2"
}
putdwptheme(){
	scp -v "$1" sfdirtadmin@72.167.232.226:~/html/dirtlab/development/wordpress/wp-content/themes/dirtlab/"$2"
}
putdirtfolder(){
	scp -vr "$1" sfdirtadmin@72.167.232.226:"$2"
}
alias dtheme='cd /var/www/wordpress/wp-content/themes/dirtlab'
getdirt(){
	scp -v sfdirtadmin@72.167.232.226:"$1" .
}
getdirtfolder(){
	scp -vr sfdirtadmin@72.167.232.226:"$1" .
}
getdirtfolderplace(){
	scp -vr sfdirtadmin@72.167.232.226:"$1" "$2"
}

putamy(){
scp -v -P 21098 -i~.ssh/id_dsa.pub "$1" ichgof@199.188.200.61:~/public_html
}

putamyfolder(){
scp -vr -P 21098 -i~.ssh/id_dsa.pub "$1" ichgof@199.188.200.61:~/public_html
}


logtheme(){
	ssh -v sfdirtadmin@72.167.232.226:/html/
}
alias dirtbackup='getdirtfolderplace html/sfdirtlab/public/wordpress/wp-content/themes/dirtlab ~/webprojects/dirtlab/wp_dirt_theme'

alias dirtpluginbackup='getdirtfolderplace html/sfdirtlab/public/wordpress/wp-content/plugins ~/webprojects/dirtlab/wp_dirt_theme'
alias tamtheme="cd /var/www/wordpress/wp-content/themes/tambikes"
alias tambackup='getdirtfolderplace html/awongh/development/wordpress/wp-content/themes/tambikes ~/webprojects/tambikes/backup'

alias tamupdate='putdirtfolder /var/www/wordpress/wp-content/themes/tambikes html/awongh/development/wordpress/wp-content/themes'

alias awbackup='getdirtfolderplace html/awongh/public ~/webprojects/awongh/backup'
alias extralive='cd /var/www/extras/tag/branches'
alias extra='cd /var/www/extras/tag/trunk'
alias extrassvn="svn co https://awongh.springloops.com/source/extratag/trunk --username awongh"
cobranch(){
    svn co https://awongh.springloops.com/source/extratag/branches/extratag --username awongh
}
#alias replacebranch='svn copy https://awongh.springloops.com/source/extratag/trunk https://awongh.springloops.com/source/extratag/branches/extratag --username awongh'

replacebranch(){
    svn copy https://awongh.springloops.com/source/extratag/trunk https://awongh.springloops.com/source/extratag/branches/"$1" --username awongh
}

alias rroute='cd /var/www/route/ruby-routing-osm'
alias rroutesvnco='svn co https://ruby-routing-osm.googlecode.cm/svn/trunk ruby-routing-osm --userame akira@awongh.com'

alias marakana='cd ~/tmp/mrails/rails1'
alias amplafijs='cd ~/amplafi/amplafi-web/src/main/webapp/js/amplafi'

alias startmemcached='memcached -p 11211 -vv'

alias startmemcachedb='memcachedb -p21201 -vv'
startdailybooth(){
	#spawn access and error logs
		#php
		#mysql
		#apache local
		#apache admin
		#nginx local
		#nginx admin
	#start sphinx
	#start gearmand
        #gnome-terminal -x gearmand
	#start memcachedb
        gnome-terminal -x memcachedb -vv -p21201
	#start memcached
        gnome-terminal -x memcached -vv -p11211
	#enable all sites
        sudo a2ensite local.dailybooth.com
        sudo a2ensite admin.local.dailybooth.com
	#reset apache
        sudo /etc/init.d/apache2 reload
	#reset nginx
        sudo /etc/init.d/nginx restart
}
stopdailybooth(){
    #stop nginx
    sudo /etc/init.d/nginx stop
    #dissable apache sites
    sudo a2dissite local.dailybooth.com
    sudo a2dissite admin.local.dailybooth.com
    #enable default site
    sudo a2ensite default
    #reload apache
    sudo /etc/init.d/apache2 reload
}
resetdailyboothdb(){

    #erase all leftover pictures
    find $PWD/DailyBooth/files/pictures -name *.jpg | xargs rm

    #drop and recreate db
    mysql -u root -e "
        DROP DATABASE dailybooth;
        CREATE DATABASE dailybooth;
    "
    #import files
    mysql -u root -h localhost dailybooth<$PWD/DailyBooth/schema/2010-05-24/site.sql
    mysql -u root -h localhost dailybooth<$PWD/DailyBooth/schema/drop_twitter_creds_from_users.sql
    mysql -u root -h localhost dailybooth<$PWD/DailyBooth/schema/set_default_values_for_pictures.sql
}

alias baseb='ssh -v -p 20068 browardh@advanced96.inmotionhosting.com'

putbbfolder(){
    scp -vr -P 20068 "$1" browardh@advanced96.inmotionhosting.com:"$2"
}

getbbfolder(){
    scp -vr -P 20068 browardh@advanced96.inmotionhosting.com:"$1" .
}

getbb(){
    scp -v -P 20068 browardh@advanced96.inmotionhosting.com:"$1" .
}

putbb(){
    scp -v -P 20068 "$1" browardh@advanced96.inmotionhosting.com:"$2"
}

alias hsmroot='cd /home/awongh/code/work/hsm/svn/trunk/src/site/www/'
alias hsmnewroot='cd /home/awongh/code/work/hsm/new/hsm'
alias hsmcheckout='svn --username akira co http://svn.hotshotmedia.com/svn'
alias hsmnewcheckout='svn --username akira --password Hsm1b3st co https://hsm.sourcerepo.com/hsm/hsm'
alias sbmcheckout='svn --username akira --password Hsm1b3st co https://hsm.sourcerepo.com/hsm/sbm/trunk'

setfoto(){
    sudo a2dissite defualt
    sudo a2dissite www.dev.snapshotscholar.com
    sudo a2ensite www.dev.fotovotr.com
    sudo /etc/init.d/apache2 restart
}
setsnap(){
    sudo a2dissite defualt
    sudo a2dissite www.dev.fotovotr.com
    sudo a2ensite www.dev.snapshotscholar.com
    sudo /etc/init.d/apache2 restart
}

setdefault(){
    sudo a2dissite www.dev.fotovotr.com
    sudo a2dissite www.dev.snapshotscholar.com
    sudo a2ensite
    sudo /etc/init.d/apache2 restart
}
alias fbmg='ssh -v root@dev.snapshotbattle.com'

getfbmg(){
    scp -v root@dev.snapshotbattle.com:"$1" .
}
mgetfbmg(){
    scp -vr root@dev.snapshotbattle.com:"$1" .
}
putfbmg(){
    scp -v "$1" root@dev.snapshotbattle.com:"$2"
}

multiputfbmg(){
    scp -vr "$1" root@dev.snapshotbattle.com:"$2"
}

mgjsput(){
    putfbmg "$1" /var/www/hsm/public/defualt/static/js/facebook-match-game.js
}
alias facetest='ssh -v -i ~/.ssh/hsmkey root@www.test.snapshotscholar.com'
alias fotovotrtest='ssh -v -i ~/.ssh/hsmkey root@www.test.fotovotr.com'
alias facealpha='ssh -v -i ~/.ssh/hsmkey root@www.alpha.snapshotscholar.com'
alias facelocal='cd /var/www/code/work/hsm/svn/trunk/'
alias seleniumserver='/usr/bin/java -jar /home/awongh/applications/selenium-rc/selenium-server.jar'
alias sbsdtest='ssh -v -i ~/.ssh/hsmkey root@www.test.shutterbugshowdown.com'
alias sssPROD='ssh -v -i ~/.ssh/hsmkey akira@app1.internal.snapshotscholar.com'
alias excludegrep="grep --exclude-dir=\*.svn\* -Rni '$1' \."
alias testsrvr="ssh -v awongh@www.test.snapshotscholar.com"

puttestsrvr(){
    scp -vr "$1" awongh@www.test.snapshotscholar.com:"$2"
}
cleardb(){
	mysql -u root -h localhost user 	< sql/$1
	mysql -u root -h localhost photo	< sql/$1
	mysql -u root -h localhost log	 	< sql/$1
}
alias sssqa='ssh -v akira@www.qa.snapshotscholar.com'

getapage(){
	wget --recursive --no-clobber --page-requisites $1
}
   # dont overwrite same name files
     # --no-clobber \
     # --page-requisites \
	 # name everything html
     # --html-extension \
	 # make all links point locally
     # --convert-links \

	 # don't follow domains outside website.org
     # --domains website.org \
	 # dont get domians parent pages
     # --no-parent \


uberg(){
	foo="grep --color=always --exclude-dir=\\*i18n\\* --exclude-dir=\\*.svn\\* --exclude-dir=\\*smarty_compiled\\* --exclude-dir=\\*log\\* --exclude=\\*min.js\\* --exclude=\\*cscope.out\\* --exclude=\\*tmp\\* -A2 -C2 -Rni \"$1\" ."

	echo ${foo}

	eval "${foo}"

	res=$?

	echo $1
	return ${res}
}
alias sbmqa='ssh -v -i ~/.ssh/sbmkey2 awongh@1.web.qa.shutterbugsocial.com'
alias sbmqa2='ssh -v -i ~/.ssh/sbmkey2 awongh@2.web.qa.shutterbugsocial.com'
alias sbmdev='ssh -v -i ~/.ssh/sbmkey2 awongh@ec2-23-20-119-247.compute-1.amazonaws.com'

alias sbmqadb='ssh -v -i ~/.ssh/sbmkey2 0.db.qa.shutterbugsocial.com'

alias sbmqamongo='ssh -v -i ~/.ssh/sbmkey2 mongo1.db.qa.shutterbugsocial.com'

alias yoshidream='sudo ssh -v -i~/.ssh/sbmkey2 awongh@rijl-al-awwa.dreamhost.com'
alias yoshidream2='ssh -v -i~/.ssh/sbmkey2 yosyam2@rijl-al-awwa.dreamhost.com'
alias mong='sudo /usr/bin/./mongod --fork --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log'
alias sphinxd="/usr/bin/searchd -c application/config/sphinx.conf --listen localhost:3312"
alias sphinxindex="indexer -c application/config/sphinx.conf --rotate --verbose --all"

acd(){
 	sudo /usr/bin/acdcontrol /dev/usb/hiddev1 $1
}
alias runq='/usr/bin/php -q public/index.php --uri=queue/daemon --queue=banning --max_priority=5 >> /var/log/php_errors.log'

alias vimswapclean='find . -name *.swp -name *.swo -name *.swn -exec rm -i '{}' \;'

alias cscopefilescreate="find . -name '*.php' -o -name '*.js' -o -name '*.tpl' ! -name '*.svn' ! -name 'smarty_compiled' -name '*min.js*'"

alias mdump='mongodump --db messages --collection objects_flags -o objects_flags_dump'

alias mrest='mongorestore --db messages --collection objects_flags --verbose objects_flags_dump/messages'

sbmlessc(){

	main="/home/awongh/node_modules/.bin/lessc /home/awongh/code/work/hsm/new/sbs/sbm/assets/StyleGuide/less/sbm_main.less /home/awongh/code/work/hsm/new/sbs/sbm/public/static/style/sbm_main.css --verbose"
	admin="/home/awongh/node_modules/.bin/lessc /home/awongh/code/work/hsm/new/sbs/sbm/assets/StyleGuide/less/sbm_admin.less /home/awongh/code/work/hsm/new/sbs/sbm/public/static/style/sbm_admin.css --verbose"

	eval "${main}"
	res=$?
	echo $1

	eval "${admin}"
	res=$?
	echo $1
}

lessco(){

	if [[ -z $1 || -z $2 ]];then
		echo 'both arguments are needed'
		# exit
		return
	fi

	find $1 -name '*.less' -printf '%P\n' | while read name; do
		FROM=$(echo $1'/'$name)
		TO=$(echo $2'/'$name | sed "s|\.less|\.css|")
		TO_DIRNAME=$(dirname $TO)
		if [ ! -e $TO_DIRNAME ];then
			# mkdir -p $TO_DIRNAME
			echo "mkdir -p "$TO_DIRNAME"\n"
		fi
		echo 'Compiling' $FROM '->' $TO '\n'
		echo "lessc --verbose $FROM $TO\n"
		# foo="lessc --verbose "$FROM" "$TO
		# eval "${foo}"

		# res=$?

		# echo $1
		# return ${res}
	done
}

yermom(){

	admin="node --debug-brk /home/awongh/node_modules/.bin/lessc /home/awongh/code/work/hsm/new/trunk/assets/StyleGuide/less/sbm_admin.less /home/awongh/code/work/hsm/new/trunk/public/static/style/sbm_admin.css "

	eval "${admin}"
	res=$?
	echo $1
}

alias gitpushcheck='git log --branches --not --remotes'

gettyr(){
    scp -v -P 21098 ichgof@199.188.200.61:"$1" .
}

puttyr(){
    scp -v -P 21098 "$1" ichgof@199.188.200.61:"$2"
}

putmultityr(){
    scp -vr -P 21098 "$1" ichgof@199.188.200.61:"$2"
}

getmultityr(){
    scp -vr -P 21098 ichgof@199.188.200.61:"$1" .
}

alias tyrlogin='ssh -vv -p 21098 ichgof@199.188.200.61'

alias xcbdb='xcodebuild -sdk iphonesimulator6.1 -configuration Debug clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO'

new-box(){
    vagrant box add "$1" ~/Downloads/lucid64.box
}
new-hbox(){
    vagrant box add "$1" ~/Downloads/heroku.box
}
alias mysql=/usr/local/mysql-5.6.11-osx10.7-x86_64/bin/mysql
alias passwords='gpg -d ~/.passwords.gpg'

psql(){
	main="/Applications/Postgres.app/Contents/Versions/9.4/bin/psql -p5432 $@"
	eval "${main}"
	res=$?
	echo $1
}
createdb(){
  main="/Applications/Postgres.app/Contents/Versions/9.4/bin/createdb $1"
  eval "${main}"
  res=$?
  echo $1
}
dropdb(){
  main="/Applications/Postgres.app/Contents/Versions/9.4/bin/dropdb $1"
  eval "${main}"
  res=$?
  echo $1
}
