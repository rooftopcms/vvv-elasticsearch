# Init script for VVV Auto Site Setup
echo "Commencing $site_name Site Setup"

#Create htdocs for elastichq
if [ ! -d htdocs ]
	then
	echo "Making htdocs folder"
	mkdir htdocs
	# Move into htdocs to run 'wp' commands.
	cd htdocs
	
	# Move back to root to finish up shell commands.
	cd ..
fi

# install java 
echo "installing java"
sudo apt-get install openjdk-7-jre-headless -y

if [ ! -d /usr/share/elasticsearch ]
	then
	url=`wget -q -O- elasticsearch.org/download | grep -i -o -m 1 'https://.*\.deb'`
	version=`echo $url | sed -e 's/.*elasticsearch-\(.*\)\.deb/\1/g'`
	wget $url
	sudo dpkg -i elasticsearch-$version.deb
	invoke-rc.d elasticsearch defaults
fi

# start ES
sudo service elasticsearch start

if [ ! -f htdocs/index.html ]
	then
	echo "Installing ElasticHQ"
	#download elasticHQ
	url='https://github.com/royrusso/elasticsearch-HQ/zipball/master'
	wget $url
	unzip master
	cd royrusso*
	mv * ../htdocs
	cd ..
	rm -rf royrusso*
	rm master
fi